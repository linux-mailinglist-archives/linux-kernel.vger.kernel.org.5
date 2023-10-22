Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F227D2357
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJVOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:17:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB0E7;
        Sun, 22 Oct 2023 07:17:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bdf5829000so358101466b.0;
        Sun, 22 Oct 2023 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697984245; x=1698589045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RMaQYL7VWn5dUS6/mp9AuU+h6Mgmj1GyOYjCOvXr5CY=;
        b=DFeB/WEcAtVaGcExcx4GUO1NT2KmS6t3/A7P8l6XC2O1CpYp4cdeQkR7szj4Jkl4Cf
         CU3z2FddyLfdmTq3REwrHpuZkVmV2FqHevRvOzWqWzZ8RmOR5FgHgRKIp1EdrtKR+tlc
         VpepuAzhbU10AvfgFmudmXIn7D1888GPI84oiS7LdbJGi6uTTtcTFexmSijaZGliMJCD
         o+amXh6DgfG511dx4yDAD/AvQjDAaUxWkVHN/y0gHGQv+PxFPOzQpJfv1UneyYrdcA6A
         zZqEW2HxVdraKMMPbLvxrg/qT6uKyJwS84EW8Y1p6nHpg0TBGyexrKGOkc1AxeyGLm4/
         QFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697984245; x=1698589045;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMaQYL7VWn5dUS6/mp9AuU+h6Mgmj1GyOYjCOvXr5CY=;
        b=GkJukh9/Pq87ZlUBv03M5bY4bz+yisYkGHwCCm3hXC2SM2tp/otIc5E7jOE3MnSyM2
         khTVlfCHR+0iNi4FT97O8EH6gRnQD/B8m34By+F3cklUI+0SUkUQdOBpZfm7ftSE/nLc
         M1NbpptPEJEL2yjrtS/Sjugtn2JNf2nv7zAy0rgEr5s+wqjHEFFSVKu/+HKMI8BkunuP
         s0OsV6HEM6sfCL3aScRMooHOrikJOcokr1n7EQLXXiUbD6sQ+VdJQDlTlZf9du3sU9fK
         EQOtLup8MWTo1dYvQrPhG5hTwMeqDC4qGnxs3Ms1t1gPZ0LdvZcGRrQpzpO4lyr1ogKv
         oiwg==
X-Gm-Message-State: AOJu0Yy7Nv5vhAB8JmRWKsu7kADjaVHNIsseiExwCKFie6l/XxEYYOZs
        zfOV6Z+T4X/IEvRcTWVvECLOcGWdsNVIWw==
X-Google-Smtp-Source: AGHT+IErw0Qbe+MsGsYAhYdmSQEJyNSTHTrFmCIj+RyVRCxOvHwI+S/94+caxGkzYAXul/xgjXlqWQ==
X-Received: by 2002:a17:907:70e:b0:9bf:5771:a8cf with SMTP id xb14-20020a170907070e00b009bf5771a8cfmr5065125ejb.70.1697984244708;
        Sun, 22 Oct 2023 07:17:24 -0700 (PDT)
Received: from [192.168.0.14] (ip-213-220-240-165.bb.vodafone.cz. [213.220.240.165])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906468500b00992b2c55c67sm5120053ejr.156.2023.10.22.07.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 07:17:24 -0700 (PDT)
Message-ID: <c998e99a4b8051b62776c66afb1ccd516d888d63.camel@gmail.com>
Subject: Re: Old WiFi modules -- for testing?
From:   Rostislav Lisovy <lisovy@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>
Date:   Sun, 22 Oct 2023 16:17:23 +0200
In-Reply-To: <872e8be6-c0d0-4e5f-94d8-e5c021d24585@gmail.com>
References: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
         <ZTUIJHf1vdSxkXeX@debian.me>
         <d85050999a2944a921a38352d1c371fdb3b8c29e.camel@gmail.com>
         <872e8be6-c0d0-4e5f-94d8-e5c021d24585@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What patches? Have you read my original email? :)

I am offering the modules to the linux-wireless project for free...
Maybe they can be used for testing or some "training activities".

If not... no problem and I can get rid of them is some other way.

Rostislav



On Sun, 2023-10-22 at 21:09 +0700, Bagas Sanjaya wrote:
> On 22/10/2023 19:31, Rostislav Lisovy wrote:
> > Unfortunately I do not have any further info than what is on the
> > pictures.
> >=20
>=20
> I'm confused then...
>=20
> Anyway, you can try submitting patches as contributor (see
> Documentation/process/submitting-patches.rst for details).
>=20
> Bye!
>=20
