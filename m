Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9BF7D9975
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbjJ0NOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjJ0NOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:14:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113CC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:14:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso15632005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698412456; x=1699017256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9FU4UMfqPLCxvyDv8DDhP0GwF/fTJfQUUDgXiQIovo=;
        b=aeL671J+sY7Z75Ns0yn3skYtE7QbXq6KYTBhbfVVef23iSI1zB83+LD6I3jvInQy50
         7Xzv3Vu1e5CvwjhPYJ8kGjvxeHaeDgXqwulbsBioz/ZLB0t6C1GBlWbGhMgyIIqnD0Ym
         oO3rmAam+luA9HSiUiwCLHmUY3T6heODl9xR/xmLPz6fkAqfjbyV7PZ3K1gNTAGGW1ot
         8sH3psGoQWrgHCwBgbURsi6EYVGWd5N8plBepnvOrH05HzrHPpKQK27xZr+CCFFG8wDM
         TxVBhpwBys1VU9Y74V45lzzcY59UMPoyJ463XAbfTWu1jdOnrye5Vvd3AQQYcFGLUhlx
         nHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412456; x=1699017256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9FU4UMfqPLCxvyDv8DDhP0GwF/fTJfQUUDgXiQIovo=;
        b=nRGmydGWpFIcCM3APrJ65YikvPHIn8UaPK4qabsrZosDhPlEETNZ6J6nv1ROBWVwnU
         SKLlBIodIIQGNg2o8LjFXXEdJUGQs4ikZg+iNMcoYklQucGjqAiMwGW4k5+p4WPqcDpx
         YncWCMhwENtCIsrvLt39sZnal1otlIqUU9DoVX69F2VVA5km5X+JOO5k1z9pfqt8ykbs
         6mWF35FG7b9hsoQduW3+J0v9WmO836YBxVB+ZZPkMgQdnVuG1M+5fh71kNnZYCqixGFP
         LB2bqX+kzZG/Qj4D/WE3e6Ayh4Al03beAyFyQ48WTU3t9DwBL2Pm7RQ/ockQ3nKstmVq
         Xafg==
X-Gm-Message-State: AOJu0YzTnQDSdFAmEQaTvx2I6K1WjF/gZZGf5a5m0NQlxqgvs1qoL1Ml
        vNbiHzwtOGaMBA9YEp8lWpwy2w==
X-Google-Smtp-Source: AGHT+IGOGBprN87Ha5ocLSpszBaqqcKWfRciNOH8gUGz9yPPK++UL0stLYDzS0BQFpfzScCRP5zGZg==
X-Received: by 2002:a05:600c:1f92:b0:405:959e:dc7c with SMTP id je18-20020a05600c1f9200b00405959edc7cmr2242338wmb.30.1698412455416;
        Fri, 27 Oct 2023 06:14:15 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b0040770ec2c19sm5075966wmq.10.2023.10.27.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:14:15 -0700 (PDT)
Message-ID: <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:14:14 +0100
In-Reply-To: <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
         <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
         <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
         <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
         <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
         <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
         <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
         <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
         <2023102731-wobbly-glimpse-97f5@gregkh>
         <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
         <2023102740-think-hatless-ab87@gregkh>
         <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-27 at 15:03 +0200, Miklos Szeredi wrote:

> Again, upstream and downstream.=C2=A0 There's a reason why some companies
> have upstream first policies: because it's less painful in the long
> run.=C2=A0 Android having decided to go ahead and add that patch is not m=
y
> problem, and I really really don't want to care.
>=20
> Having said all that, if there's a regression that someone reports
> for
> upstream flags (even on a vendor kernel), I'll just revert the patch
> right away.

The patch in question has broken all users that use the higher flags
and that don't use your version of libfuse, not just Android. You're
filtering them out now when you didn't at the time that those
('official) high flags were added. There are a couple more high flags
than just the one that Android added.


Cheers,
Andre'

