Return-Path: <linux-kernel+bounces-48756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F78460D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6381028AA5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785238562D;
	Thu,  1 Feb 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED4tcWCM"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F985270;
	Thu,  1 Feb 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815253; cv=none; b=OxgyNZVOXITddVZMy3AGInQrBj3lW0Hg9oljqLXNWtB7kiDRBX/NXMKVWvAxQjfypsN20XuDeULKWq4+4ofHHnLJiqXc3Snk7166qXKv4N6UYUuT55eQAXD4yc29+rLVgpmlmULV+bI4FWK8SBov04WLdyfSRXlpxd6L7Y5zMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815253; c=relaxed/simple;
	bh=0zW/ynUDROed77RIRLq/hCLZRf5+NOXfoIJZKFpkiB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJZTIU/MF2VFAGJ8bRQbaOGUN6jrdJ2eu5ySlrEt+ckHre2U8QxPDvyXc1pL59ViF/nZNrPB87WMtop3Vj2yZAaSlpiQOG9/7Uaok7LG9ODi5iF+vHx3FBgjlXcV3L3PG+fFo1odbxAH4TZTjYnjhEi4VXK5nA/NNtLQDOHfgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED4tcWCM; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785388b3281so78563185a.2;
        Thu, 01 Feb 2024 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706815251; x=1707420051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyJu/UUVOGO6WHBbFcUHcwW7sN0BImG4+VVTXTyQNHI=;
        b=ED4tcWCMJtFxIYQSAhvFY3oNdiZ5MU0AtYmENLWiERlc9Yf0pcCqlitgcmP+F6pddM
         CHy9oLiRLYboo52teQI+EESdHj2UGjFJ3MH29JPpeQsEiUB/IsNbAjRM+mM9c6s8cKMq
         PbK6OP/HVXRJ394GSFRtv2Byr2a8FdqaIQqxTXoMcafFFM75zGdYwMmpWbfDeHpPcfg/
         cCb1VjFcexJRmZ3XdGaVwKXcU8sWsEBveoIlsRZ6LNgVHqejAsGEPkxvosSKYQDe11OV
         PMiUU4CDmY9J6Pg0OjQ1jjO7Vr2LcMbiVf3JBDB/Iht0QsmVmAnKrcMtATXuxhBSc+hH
         +cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815251; x=1707420051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyJu/UUVOGO6WHBbFcUHcwW7sN0BImG4+VVTXTyQNHI=;
        b=dQG3Rrx/2BAkBlXsf+k6dE4DMtmVnjU3PbQx6YbwbuMRcw9W+6Fbo2vrIjB4obhL8Z
         iQ7MDpDBj1b1dKRG+8HAsL/ZJGtejkRSp2qDs1l+GOfXUz2f6OpZtOz45cVI20aMuQPX
         g4paHv8/7uCgK+FiHqEvCgQMgLI2+O5hDVNUakcWiBBYkcMLpQkUu7a0eQHx3oQIzh6J
         WLK3OmQHXyhfwsNbljxXw7Vs44esvs8WOhtqYqxPWOVOD2z26aIm0f7ShKDlVfoCJq1f
         Q7jnxaD5K8VUBsr7M24VwSxFVCyK5m5czUkg+77HepCFWTWgYaOSDmIq1mDOfa9DuAc1
         Qq3g==
X-Gm-Message-State: AOJu0YxqAohSb9kROILjNwsNjqCjg9gGghzPK71tzipFV+R2Rb0ayHIY
	sxqvkXfCak/hjj5yKw+k5akEtSEXD6NLA5ZZLAD+pwPCZEBGKjB9
X-Google-Smtp-Source: AGHT+IHnQnFWMrsG0p/IkJPB2EmpB/t51E19lnSbEfZRbcAwarAS3iVVDOSaUG4TdNHgWFimkAh1uw==
X-Received: by 2002:a05:620a:24c6:b0:785:45a7:d484 with SMTP id m6-20020a05620a24c600b0078545a7d484mr111677qkn.27.1706815251035;
        Thu, 01 Feb 2024 11:20:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpa0p8plrVAVnDE6wbLgKOmCGS+l0GnY0I7Y64VOiY/HhEEF6VbxwS1/0Uab9n1Gh69uonUthtavq2+BXoHqADXMsXcFNxSecwMmCcN0hUGj/j2p7RAg8+O3VlWq2/3po1DjdpGPpj7IMAdS2ti8/st/HV8RG8ePGCUcAw6ALCpwAH8tqSnOpcXeGiJ8UQMSWRRSdoZMH/aGLWTEOSrFDNcwOh58e82LdutVsvh5L7xSry39s4Q9m0I18dsq+VE8J5cp/jgs593VyvDkRXB/rzyVieB1JYZqxZIPgrFlHJBIRSXrbudw4nJvyeAtPdCXtqP/Tf95tOITyqsYAwrPZAv2SgCtqDUsbLE2cZQbetehOpQk5RYPR8NR8s36tSt8/Pg9nTdR4n+VwyDFV0tK4XUJe5jA==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b00783df78821dsm73336qkb.25.2024.02.01.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:20:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id F20F827C0060;
	Thu,  1 Feb 2024 14:20:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 14:20:49 -0500
X-ME-Sender: <xms:Ee-7ZTpq-MtTlEEg1tu3PfgwDtuYmsg-8xxKEL_67Tr3Y3N1wbx0Gg>
    <xme:Ee-7Zdpyo4lyA05jrylauQEIXseeBZ74fnTn40-0IOFBKkIRN7R-trbIdUE4JkR5R
    OutRAvYyXLsTAwk7w>
X-ME-Received: <xmr:Ee-7ZQMbIFhk9MnVYDWHLDQMIXcMZL4cegMQXuU2xfZL1PidUzj1SoCHOlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Ee-7ZW6elyNywtxUiA9ed2p7uXdE2Gqtzlnl7WGkKLRMwS0dX4QgRQ>
    <xmx:Ee-7ZS4NkQ28r_Uj-ASs4IgX3dNnGKE4u6OW4L7GSKN8tzdw-bDsAg>
    <xmx:Ee-7ZeiM6KMqLYlkaQreBxyyXe93U5ZOCfwAvy51QTsYcPGV6sRnDw>
    <xmx:Ee-7ZSywnsXRT0jOvJFduO_IkIqMvqRcCV-IRvKcTLIdSjj1Y24V4w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 14:20:49 -0500 (EST)
Date: Thu, 1 Feb 2024 11:19:43 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] workqueue: rust: sync with `WORK_CPU_UNBOUND` change
Message-ID: <Zbvuz5iym2MhNzPQ@boqun-archlinux>
References: <20240201190620.18064-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201190620.18064-1-ojeda@kernel.org>

On Thu, Feb 01, 2024 at 08:06:20PM +0100, Miguel Ojeda wrote:
> Commit e563d0a7cdc1 ("workqueue: Break up enum definitions and give
> names to the types") gives a name to the `enum` where `WORK_CPU_UNBOUND`
> was defined, so `bindgen` changes its output from e.g.:
> 
>     pub type _bindgen_ty_10 = core::ffi::c_uint;
>     pub const WORK_CPU_UNBOUND: _bindgen_ty_10 = 64;
> 
> to e.g.:
> 
>     pub type wq_misc_consts = core::ffi::c_uint;
>     pub const wq_misc_consts_WORK_CPU_UNBOUND: wq_misc_consts = 64;
> 
> Thus update Rust's side to match the change (which requires a slight
> reformat of the code), fixing the build error.
> 
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72=9PZ89bCAVX0ZV4cqrYSLoZWyn-d_K4KpBMHjwUMdC3A@mail.gmail.com/
> Fixes: e563d0a7cdc1 ("workqueue: Break up enum definitions and give names to the types")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> Tejun: here is the formal patch as you requested. Please feel free to
> either take it or to rebase to fix the old commit. Thanks!
> 
>  rust/kernel/workqueue.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 498397877376..d00231e18007 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -199,7 +199,11 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
>          // stay valid until we call the function pointer in the `work_struct`, so the access is ok.
>          unsafe {
>              w.__enqueue(move |work_ptr| {
> -                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
> +                bindings::queue_work_on(
> +                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
> +                    queue_ptr,
> +                    work_ptr,
> +                )
>              })
>          }
>      }
> 
> base-commit: 15930da42f8981dc42c19038042947b475b19f47
> --
> 2.43.0
> 

