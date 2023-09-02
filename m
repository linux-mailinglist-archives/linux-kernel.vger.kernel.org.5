Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B42790846
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjIBOed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIBOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:34:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D610EB;
        Sat,  2 Sep 2023 07:34:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so2113f8f.1;
        Sat, 02 Sep 2023 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693665264; x=1694270064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LEnYY2fstYIsmMY7pLao9nO8hPctUJEbYLViJghGc0=;
        b=AlRdnb6hak2ke9J5+VveahbOAJS2TUdLUAxKKedX2oMMCRsTT3epy1jSdgPdi/7vi/
         Cf9St3nB9VkyWx3TP12DAKzGHe/6Fkq8QItMDUY74RUvgx4ef5Dr+AbDIKBYH5OxhMd0
         EWo5Jsz5UVjrY/ELZDv2K94tiRWQeO+ULkluh4Vd3YFp4tKpQTqcimVqB7bZ3dTftYmz
         kIeieEE8xV5r1mQ4cWHBnG9pJFjmhWONJMEKnxo1QE8D48ncnaX7FFt11X+ZCB6OEFVF
         py9TN/d7F8bMxg0UYbx5vKsSV+keSMyBqJ9bmtMLwWDxSbiS1k0WQF29P8HDuctsPoV4
         TTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693665264; x=1694270064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LEnYY2fstYIsmMY7pLao9nO8hPctUJEbYLViJghGc0=;
        b=aW/NLoTDPIvO2v5e7yK0EB7Nq+svFAuyRWVqFyWJYcRR1AGSDPAQOzVnjp7QKkXT51
         fsBkOv9oqulqB9QL1o0xu8etAWAwT5v3lzUg5I7geYYmY9nIXMBor9KO8bodaNGYAfES
         uNTwQznio0pfdiAp7/CRcxXFIBMqVn99zWs+t+eXdQhI7uPQ/6EOlq5zYZcj9rBbTC3u
         x2xjkuMfNRMPtudSsNiWAbK6NVVlqSZDI4w859SQtP73OAHmzx90IxLucx5HkE7sVPX5
         vWIWCjPPvnqGxqtvEfUTL4n9zsIieN7LMQtViNlwD2kuCrCDPGHLC9i6KKgPQFkS1K/K
         b/Yw==
X-Gm-Message-State: AOJu0Yyhgo/5SoPiDZjylVYaRJ9u0MaOfmzsIkwHSenUFgRq53YtE5jR
        jHvHq8s/r/yfoKgsnB/+whY=
X-Google-Smtp-Source: AGHT+IE+L/AuvMNg3BeZbTTlyRe8GsYHB2IcJZPuf2AYkptiWp2rXAcyeMyAUqPj9pdVSJmI2EnL9Q==
X-Received: by 2002:a05:6000:1291:b0:315:a235:8aa8 with SMTP id f17-20020a056000129100b00315a2358aa8mr6301607wrx.2.1693665264243;
        Sat, 02 Sep 2023 07:34:24 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm8143007wmi.33.2023.09.02.07.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 07:34:22 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 51D71BE2DE0; Sat,  2 Sep 2023 16:34:21 +0200 (CEST)
Date:   Sat, 2 Sep 2023 16:34:21 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Zheng Wang <zyytlz.wz@163.com>, s.shtylyov@omp.ru,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH net] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <ZPNH7bdwe4Zir6EQ@eldamar.lan>
References: <20230309100248.3831498-1-zyytlz.wz@163.com>
 <cca0b40b-d6f8-54c7-1e46-83cb62d0a2f1@huawei.com>
 <CAJedcCy2n9jHm+uS5RG1T7u8aK8RazrzrC-sQhxFQ_v_ZphjWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCy2n9jHm+uS5RG1T7u8aK8RazrzrC-sQhxFQ_v_ZphjWA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 11, 2023 at 12:38:10AM +0800, Zheng Hacker wrote:
> Yunsheng Lin <linyunsheng@huawei.com> 于2023年3月10日周五 09:12写道：
> >
> > On 2023/3/9 18:02, Zheng Wang wrote:
> > > In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> > > If timeout occurs, it will start the work. And if we call
> > > ravb_remove without finishing the work, ther may be a use
> >
> > ther -> there
> >
> 
> Sorry about the typo, will correct it in the next version.
> 
> > > after free bug on ndev.
> > >
> > > Fix it by finishing the job before cleanup in ravb_remove.
> > >
> > > Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > ---
> > >  drivers/net/ethernet/renesas/ravb_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > > index 0f54849a3823..07a08e72f440 100644
> > > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > > @@ -2892,6 +2892,7 @@ static int ravb_remove(struct platform_device *pdev)
> > >       struct ravb_private *priv = netdev_priv(ndev);
> > >       const struct ravb_hw_info *info = priv->info;
> > >
> > > +     cancel_work_sync(&priv->work);
> >
> > As your previous patch, I still do not see anything stopping
> > dev_watchdog() from calling dev->netdev_ops->ndo_tx_timeout
> > after cancel_work_sync(), maybe I missed something obvious
> > here?
> >
> Yes, that's a keyed suggestion. I was hurry to report the issue today
> so wrote with many mistakes.
> Thanks agagin for the advice. I will review other patch carefully.
> 
> Best regards,
> Zheng

Looking through some older reports and proposed patches, has this even
been accepted later? Or did it felt trough the cracks?

Regards,
Salvatore
