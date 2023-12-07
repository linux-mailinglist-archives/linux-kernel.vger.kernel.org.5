Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C980910B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443780AbjLGTIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjLGTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:08:22 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7648E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:08:29 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9df0a6560so560972b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1701976109; x=1702580909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8OWS2EF/jxgGIxX7cfSGEDjvCH+3JHnn1iapS5BEtE=;
        b=Pv9IcVlHfdK9pDYkLUhP3PBrcbdsbR3yPC/C1/+sc33u3YTBBHITNJOd8Oz0501b7/
         rx2TaHztpC0NOwpf0z3Yk7pbU905opt1KKhtZE7qJr2760BiwF15RN/fIMMgnESzHjh4
         bcYeMDgdILbqzjEervxU1+5Hvy74g7hd9iMd+/fDwpX7TwanSdMifIh5gNrG9LmvSYqh
         Cdk5xq1IFSzMvInQxFo8Q4ukGbZFkelHM7HCY8S9fhXXREKgoef20nXxfaQfBv0m0jz5
         YKqqEV2spc9NLseUoMKXX9yJKwpI2IQ2l0/vxWTJucbK6KKiMOaXz9HZQLZu7J69eiYJ
         QjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976109; x=1702580909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8OWS2EF/jxgGIxX7cfSGEDjvCH+3JHnn1iapS5BEtE=;
        b=aGKhMzb/G6grc8kqxOWGOsZG2CT3IUBxPmf+yd6eg0HYdegj+d72+HvYasbPvuaioQ
         xtX70t2tr9B0L9JlMBFeY3lL/pChUbdeRCivuKnEUkJeTPkYcbotReTee2fXdryVL0T1
         POJRbsfKDBmkagylNA1n2suZCVnlgzEKsH5pp/jKSyU9M4DWOqUXCrFG9OPPU4BVqL9p
         el+Jf3EJWsNoPFFYamQ3h5+qxBXXpOFGit5ZAcvqt3xrQg3k0YDkFa9hH6YnL2wh2gUU
         qsf78AU4w6lmxlAel4FsV7/7UZT/xfPS4TToXY5PSmWAZZwpLF5M5jwiBtJCN13UlH8t
         U17Q==
X-Gm-Message-State: AOJu0YziOmRrFn+9WOCFS8qX2waRYDmljGkQOSF1dlCJpH68sG22ZkRa
        kugWHJfaWF5xzDUX+uIVKkbzfQ160pwFFUg/xec=
X-Google-Smtp-Source: AGHT+IHmlEBqMLi8p7ZsVgEMreur2OTNgRYwmLDFd4yoPSVmqEsKGnS9sX3SRUQEzGPFuG0+Bp2AOQ==
X-Received: by 2002:a05:6808:148b:b0:3b9:e475:d5e1 with SMTP id e11-20020a056808148b00b003b9e475d5e1mr957229oiw.9.1701976108782;
        Thu, 07 Dec 2023 11:08:28 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:b5c::7a9])
        by smtp.gmail.com with ESMTPSA id ot20-20020a05620a819400b0077d5d1461aesm118361qkn.31.2023.12.07.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:08:28 -0800 (PST)
Message-ID: <81903c6258fe21696775a290e338cc2042a7ff64.camel@ndufresne.ca>
Subject: Re: [PATCH] media: chips-media: wave5: remove duplicate check
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Nas Chung <nas.chung@chipsnmedia.com>
Cc:     Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 07 Dec 2023 14:08:26 -0500
In-Reply-To: <9bdce1f1-b2f0-4b11-9dfd-16ca7048281b@moroto.mountain>
References: <9bdce1f1-b2f0-4b11-9dfd-16ca7048281b@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 28 novembre 2023 =C3=A0 17:39 +0300, Dan Carpenter a =C3=A9crit=C2=
=A0:
> We already verified that "ret" is zero a few lines earlier.  Delete this
> duplicate check.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/chips-media/wave5/wave5-hw.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index 3fcb2d92add8..f1e022fb148e 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -578,9 +578,6 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
>  	dev_dbg(inst->dev->dev, "%s: init seq sent (queue %u : %u)\n", __func__=
,
>  		p_dec_info->instance_queue_count, p_dec_info->report_queue_count);
> =20
> -	if (ret)
> -		return ret;
> -
>  	return 0;
>  }
> =20

