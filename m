Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CC804461
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjLEB7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:59:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B495B4;
        Mon,  4 Dec 2023 17:59:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso6016395e9.0;
        Mon, 04 Dec 2023 17:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701741547; x=1702346347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDBKOw3s0R/x34Gl0DdYfEHhp4k1EOz2IyOuhxx/RDw=;
        b=L08xTNSk5eQU3t+7yuY8dwHJdDqcp5qOVAX9qAPdQOSwnMydAxATTumbVZFOd1LZpk
         r02QCDg1fTg1Df6oenFxYMTCgt7XJGwkCZPG7FSF/YMHRioeDLY2Ki0N/5Vju9iERrIE
         xzZq7GI749vs977WligIkSl9yzhFPi7ZFgaJL6WaxGK7al7ZaNEIn5tc11ZLsIgkAQdP
         YAIRZhwXsfH46ls8en6WagtJChHaClBOO7PQXiqyAWQ5zmof17sXgXqRRRoNi5ZHevqq
         w/56GAH+2kjIYj1DNYaq8Rl9wnUngWNMdQzTKagxr0a1e00PNOlXGL/Vg6viuwhnvqOv
         N/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741547; x=1702346347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDBKOw3s0R/x34Gl0DdYfEHhp4k1EOz2IyOuhxx/RDw=;
        b=HJVpVMBTspDPqLc2iozaFr23k9CsV4CMgIEGZsrNBTq3IroTKnEwCjK0iNl2Gj0Lo8
         i8/czbeFjtwjo35g+ri/FEAWsThaK/jfXHvws2jeuMUUZCPwnjaMsqETsPkcD7lYUIIq
         4KePO3CnMMkWkj/OmG7JEOScyLz2f5Q+QdFfNVavhNdXCQ5pxzUXO1mQjdsAzoq/hqNR
         kh4WKhnMM4hyS6VCbF/a5c72K+C5Pnmx8oSQNxxjd6jHyHYSxhG/CTQHAV8RQfNIDEOW
         bn5PRegh+ul4SFWIxKg3JV88N9OsX+w+cYsC7+JB/ta9l/1beZji/HTTtO01Ob92Fc5U
         3b5Q==
X-Gm-Message-State: AOJu0YyjWSKQgzs+qGx8XSzjGD0ezxrWl7kz0fgNwMf9hUXTAJoyx3Wl
        MnZwB11yxWjOGEXgio9kRejknr1I79ajWlUg8gI=
X-Google-Smtp-Source: AGHT+IH3pk98r8xDa4KBJTXsK/VMAwQZ79RDLUR+lRWE7jhLBQZJl49OL7x+1il/lGY6CVzmTDIbZ5teWIODtZG4zyg=
X-Received: by 2002:a05:600c:444a:b0:40b:5e21:d36f with SMTP id
 v10-20020a05600c444a00b0040b5e21d36fmr31135wmn.120.1701741546663; Mon, 04 Dec
 2023 17:59:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
In-Reply-To: <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 4 Dec 2023 17:58:55 -0800
Message-ID: <CAADnVQJXtSNGuZGNfNSD2Or8hfhrxtO_cL1GckHMXc401Rg+kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/10] xfrm: bpf: Move xfrm_interface_bpf.c to xfrm_bpf.c
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, antony.antony@secunet.com,
        Yonghong Song <yonghong.song@linux.dev>,
        Eddy Z <eddyz87@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 12:56=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit moves the contents of xfrm_interface_bpf.c into a new file,
> xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd like
> to keep all the bpf integrations in a single file.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  net/xfrm/Makefile                             |  7 +------
>  net/xfrm/{xfrm_interface_bpf.c =3D> xfrm_bpf.c} | 12 ++++++++----
>  2 files changed, 9 insertions(+), 10 deletions(-)
>  rename net/xfrm/{xfrm_interface_bpf.c =3D> xfrm_bpf.c} (88%)
>
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..29fff452280d 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -5,12 +5,6 @@
>
>  xfrm_interface-$(CONFIG_XFRM_INTERFACE) +=3D xfrm_interface_core.o
>
> -ifeq ($(CONFIG_XFRM_INTERFACE),m)
> -xfrm_interface-$(CONFIG_DEBUG_INFO_BTF_MODULES) +=3D xfrm_interface_bpf.=
o
> -else ifeq ($(CONFIG_XFRM_INTERFACE),y)
> -xfrm_interface-$(CONFIG_DEBUG_INFO_BTF) +=3D xfrm_interface_bpf.o
> -endif
> -
>  obj-$(CONFIG_XFRM) :=3D xfrm_policy.o xfrm_state.o xfrm_hash.o \
>                       xfrm_input.o xfrm_output.o \
>                       xfrm_sysctl.o xfrm_replay.o xfrm_device.o
> @@ -21,3 +15,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) +=3D xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) +=3D xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) +=3D xfrm_interface.o
>  obj-$(CONFIG_XFRM_ESPINTCP) +=3D espintcp.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D xfrm_bpf.o
...
> +#if IS_BUILTIN(CONFIG_XFRM_INTERFACE) || \
> +    (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BT=
F_MODULES))
> +
>  /* bpf_xfrm_info - XFRM metadata information
>   *
>   * Members:
> @@ -108,3 +110,5 @@ int __init register_xfrm_interface_bpf(void)
>         return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
>                                          &xfrm_interface_kfunc_set);
>  }
> +
> +#endif /* xfrm interface */

imo the original approach was cleaner.
#ifdefs in .c should be avoided when possible.
But I'm not going to insist.

ipsec folks please ack the first 3 patches.
