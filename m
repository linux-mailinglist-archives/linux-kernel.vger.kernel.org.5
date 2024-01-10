Return-Path: <linux-kernel+bounces-17038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D86824775
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DEDB20FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6D286AF;
	Thu,  4 Jan 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HleWbOhz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC725553
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so524747b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704389413; x=1704994213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M5Xkeyb638fQDRDYiWI7VQRLopuLK94f8Vxf8hYN/8=;
        b=HleWbOhz679e76GSytykBuxvGYSYUNIFt893R+7EhNIb8QOcGEnf0O3CJan8OOSpib
         yibOJ/MpLopGKj/AJMVd5JcgWMTW3ApHEkgsrbV7fzX938naXfWTbxwd4oLH84VupuBF
         /HwtLAJa2debzra/sbFRxiYF3DR9URln+Hxu7DBv3iQ2Fb11Sd9bzUpQGGL6PyRHGXi1
         FM/lBbW5/KeHvUr/RBhTZNE2LhjNatF6nQLiU3gepyggjGgRmmzDQYljtaY5k9p7tZv5
         hcbnsRRGtBQR/6a+eU9pSF1G49rrotAMTFBvSk7aIr0hN2OO4hzO2AEu4CItExOMNiPj
         u/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389413; x=1704994213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M5Xkeyb638fQDRDYiWI7VQRLopuLK94f8Vxf8hYN/8=;
        b=Jrsrhykh8l+gopBvZIcgv8rqHYA9FFNsRhZ1E/ZxnPsS12CXudpRYZ6Kp06nChO+y9
         HWi91/3jI0APEKxaSMymAWsa7qJlPLs3wXJHWop85aFTvOJBZ5mABv2r8qIa4kyr0zia
         IWdXkivTf2ub2P4crMvQ5E3wrGimWK0IBUcAH6NCjTRU4eMu1lmddn6dcrZfV7cO8LAE
         J8wAbQamLHHyTKVIEtiIenxJ+QKmVBCr2neiAMsi2CwQLUzcUjjXkdY3mxUsH4+0k6s4
         9luYMhqvdCukJZs3vWeVOcP3X4dJChcop9QkiS1nJWEy0zN7RJ02o2wVp+4+rr2HMlWa
         9Ofw==
X-Gm-Message-State: AOJu0YyxYknm2xma+kJvhGUJ4gS3KdxsOlaVVj8fIAQP52jGhuXnX2rU
	lOJGgsiwVqO7HK/botaAZo4u7EtN6LX4
X-Google-Smtp-Source: AGHT+IFUhOmBAk9OB96kE3Qpi43uU1GQ0B476E1zwc0klTPuAyaqvr9pTyaxsUc7C5MkJEEW7hrEiQ==
X-Received: by 2002:a05:6a00:2d1e:b0:6d9:b54e:9d45 with SMTP id fa30-20020a056a002d1e00b006d9b54e9d45mr960660pfb.15.1704389412771;
        Thu, 04 Jan 2024 09:30:12 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id s34-20020a056a0017a200b006d9bcf301ffsm18248878pfg.194.2024.01.04.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:30:12 -0800 (PST)
Date: Thu, 4 Jan 2024 17:30:08 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Coly Li <colyli@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-bcache@vger.kernel.org
Subject: Re: [PATCH v2 1/3] list: Add hlist_count_nodes()
Message-ID: <ZZbrIOwvVxzgZFyM@google.com>
References: <20240104164937.424320-1-pierre.gondois@arm.com>
 <20240104164937.424320-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104164937.424320-2-pierre.gondois@arm.com>

On Thu, Jan 04, 2024 at 05:49:33PM +0100, Pierre Gondois wrote:
> Add a function to count nodes in a hlist. hlist_count_nodes()
> is similar to list_count_nodes().
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  include/linux/list.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 1837caedf723..0f1b1d4a2e2e 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1175,4 +1175,19 @@ static inline void hlist_move_list(struct hlist_head *old,
>  	     pos && ({ n = pos->member.next; 1; });			\
>  	     pos = hlist_entry_safe(n, typeof(*pos), member))
>  
> +/**
> + * hlist_count_nodes - count nodes in the hlist
> + * @head:	the head for your hlist.
> + */
> +static inline size_t hlist_count_nodes(struct hlist_head *head)
> +{
> +	struct hlist_node *pos;
> +	size_t count = 0;
> +
> +	hlist_for_each(pos, head)
> +		count++;
> +
> +	return count;
> +}
> +
>  #endif
> -- 
> 2.25.1
> 

Looks good.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

