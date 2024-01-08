Return-Path: <linux-kernel+bounces-19256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8B826A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A194F1F21320
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC91118C;
	Mon,  8 Jan 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="GG1xZNxG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1C13ACF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a277339dcf4so153271566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704705264; x=1705310064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDFRteAm4wd6GlX9tJW79V47HNMeXV0mDZH/Y/EDQaI=;
        b=GG1xZNxGjvXgRqw3KmuAF59xyPju5KRFCM2rIIOhAUnoqtGVso96W1YSpNXlOzHktV
         28zv7mzTmijz9bfpmzJsg7+NfX43P2BBH6O3bbBq+cwtI//zyhJmpnfLkGcSWTk0uFQx
         R1QZ7GwIpwtqId1OB1JInfLo1WwL6mgC1+4UI0Y36dqK25mawV+WQat5hDQ93oWjqrMe
         tIX3rdNQPnD1yxiXZYIR2+ZF6MBWWXvc0BiSMuPukxaBoRi8VK4bT68wSkZ0KdH12rY4
         GVY6BekZktMk7XbeHTSZyhg7QGNp8WJKzTeUb2Wien9LcwNOCM2d2XzYHxte6a3hCL9M
         pEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705264; x=1705310064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDFRteAm4wd6GlX9tJW79V47HNMeXV0mDZH/Y/EDQaI=;
        b=dMtLTyPcY1qCTdgHmt5hQiFJDYmVv43zNYLWDEM4mGoFqRSUFWB57NMvvOZaJ9gNB5
         IVLWoauuRTGyavNk4pUL09j5if+YH0YRhGl1E2QLsSdMRxnXr9c9HaIVlVBQLIW3fSyQ
         T8IQ1sJr+fZCx77D1DXFonAQ04WvjNDdINimL3U4lMCCIBlCFlOCqNlBryusgp/CrpNl
         QhLqOzaYtiPmT5bZrvj6zMmHJfbVkeRRI5CfDt2WIlAw/wR/3C+MWiuoxFz+tpQPlymf
         BkjK++Zlmfml+0MbVfgqDqMistMdANsUlDe8sV0uVdYLPGBkrjRGk2rGVBuq+bID9Xmb
         Fh0g==
X-Gm-Message-State: AOJu0Yy9/A1JlAE6BVw11bVQE2sNmYKl0gF7xTgl8hN1B7jc/Wa5FuuN
	Ql25M4V+rE6QACFwLrpcXfIfwbT3Wrvb9aqyl7WzrEqb+Ah6YQ==
X-Google-Smtp-Source: AGHT+IFMPbT6CeTP3RZkyoNm5olSWP+ULP1JDel/8eybpZGoMegh6v8SpTzfzeejkGNK3uL3+LsOTv17z7fWiFHQOK0=
X-Received: by 2002:a17:906:1916:b0:a1d:932f:9098 with SMTP id
 a22-20020a170906191600b00a1d932f9098mr1241974eje.97.1704705263888; Mon, 08
 Jan 2024 01:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704565248.git.dxu@dxuuu.xyz> <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
In-Reply-To: <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Mon, 8 Jan 2024 10:14:13 +0100
Message-ID: <CAN+4W8isJzy=J_CciNqwUa5o7wu+RQ1_cvPYXt7_OkgjPycsDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 7:25=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This macro pair is functionally equivalent to BTF_SET8_START/END, except
> with BTF_SET8_KFUNCS flag set in the btf_id_set8 flags field. The next
> commit will codemod all kfunc set8s to this new variant such that all
> kfuncs are tagged as such in .BTF_ids section.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/btf_ids.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index dca09b7f21dc..0fe4f1cd1918 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -8,6 +8,9 @@ struct btf_id_set {
>         u32 ids[];
>  };
>
> +/* This flag implies BTF_SET8 holds kfunc(s) */
> +#define BTF_SET8_KFUNCS                (1 << 0)

Nit: could this be an enum so that the flag is discoverable via BTF?
Also, isn't this UAPI if pahole interprets this flag?

