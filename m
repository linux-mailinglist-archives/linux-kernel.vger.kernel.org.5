Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3157997A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjIILWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjIILWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:22:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7540ECF2;
        Sat,  9 Sep 2023 04:22:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso2844429f8f.1;
        Sat, 09 Sep 2023 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694258523; x=1694863323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olquqCu4VyrAvu6/3+9mCZgrXwhPnHpSc12tu4LETGw=;
        b=A5sjCcRJ8FSuQkUzSHYBsCG5aZ8sebk0Xs37biWxVDH3dDpfNe4y2lnJvIDg+v3KdT
         +vilHajhUuJuJ5+FHAV5tpvDerzXeW6sos8SkEIa28lq3DFQ9dFBQeNMGURy8Yi1/swB
         FkNNsPJjoAQjqzWiKUFR8cnzLst0c5/eaifxbiyBDEruCAdDgJwE1TccXNpI3UVfJg53
         2rqQNzf9uDaSci7JbNX+j7sz8aBJt3cbVj8lJe4Yh4Uz3JYeACp0iuAbphBaYS5otXef
         Hfm50IiFEnEA7NYUy0uhJOAGNcm7r+NP3YwZ/Tnx6JSYYhsIiEgauq3AJBl376kk1ewL
         pFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694258523; x=1694863323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olquqCu4VyrAvu6/3+9mCZgrXwhPnHpSc12tu4LETGw=;
        b=QIkoasPFWprcVfkuQGRLG36HWdBqRuLHmC324ysSMlX2/iiNmjuVzvDBl83/yTNS4G
         YKMqY61WOVEKFaIuV8/3dWJxs43XQwA3m/thMqG/7EV3nTbZxjNOR7mpCgTSURLxHViK
         IbND6xx9avPjXJJL8rsey+ACbY5U8L6N1nYihIKPxHB7ic2iG6XAex5Oh37GNG3cZXut
         ysegm/5MV0+JjmYSsmnfZSXKwBS2f3aGpEVGL3hhaSpST/769e0dCPS7MFsAfU3uyUyL
         J/RYbfxtlfL3o8A2D+0x8rszi8xfWSazw+CYKZBr0gIHm04zYfABJLiQFBwtZhYapDAi
         7AKg==
X-Gm-Message-State: AOJu0YyPmPjik7o0C2ouEg6a2NNvQ9K4YSyWoStOGWiqqx/2LkgdZVPB
        ABWNX+5O/8BZ/sMsz6wkEWY=
X-Google-Smtp-Source: AGHT+IHdd1TEfGIe6W3hDD4K43tkuCkTYFugghytEE7vKaiJjtAYo5HhIHR34ucLn8EAoi+e3RCv4g==
X-Received: by 2002:a5d:4486:0:b0:317:5b1b:1a40 with SMTP id j6-20020a5d4486000000b003175b1b1a40mr4423668wrq.49.1694258522490;
        Sat, 09 Sep 2023 04:22:02 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bce18000000b003feee8d8011sm7575920wmc.41.2023.09.09.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 04:22:01 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 1094BBE2DE0; Sat,  9 Sep 2023 13:22:01 +0200 (CEST)
Date:   Sat, 9 Sep 2023 13:22:01 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <ZPxVWVEfGnsoLeDc@eldamar.lan>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
 <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090826-fabulous-genetics-e912@gregkh>
 <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB61897793502F49240BCA903CC4ECA@DM4PR11MB6189.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 08:49:52AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Friday, September 8, 2023 12:39 PM
> To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisco.com>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> 
> > A: No.
> > Q: Should I include quotations after my reply?
> 
> 
> > http://daringfireball.net/2007/07/on_top
> 
> On Fri, Sep 08, 2023 at 06:54:06AM +0000, Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) wrote:
> > Hi Greg,
> > 
> > This change is required to fix kernel CVE: CVE-2023-1989 which is 
> > reported in v6.1 kernel version.
> 
> > Which change?
> 
> [Deepak]: I am referring below change. This below change is required to fix kernel CVE: CVE-2023-1989 which is reported in v6.1 kernel.
> 
> Subject: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
> 
> From: Zheng Wang <zyytlz.wz@163.com>
> 
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> 
> In btsdio_probe, the data->work is bound with btsdio_work. It will be started in btsdio_send_frame.
> 
> If the btsdio_remove runs with a unfinished work, there may be a race condition that hdev is freed but used in btsdio_work. Fix it by canceling the work before do cleanup in btsdio_remove.
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>
> 
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c index 795be33f2892..f19d31ee37ea 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -357,6 +357,7 @@ static void btsdio_remove(struct sdio_func *func)
>  	if (!data)
>  		return;
>  
> +	cancel_work_sync(&data->work);
>  	hdev = data->hdev;
>  
>  	sdio_set_drvdata(func, NULL);
> --
> 2.35.6
> 
> 
> > It is fixed in upstream starting from v6.3 kernel version and required 
> > to fix in 6.1 kernel version as well so we have backported this from
> > v6.3 kernel version to v6.1 and I have sent this patch for review and 
> > merging.
> 
> > Again, what commit are you referring to here.
> 
> > confused,
> 
> > greg k-h
> 
> [Deepak]: Sorry for the inconvenience that my message did not provide all the details.
> The kernel CVE: CVE-2023-1989 is fixed in upstream with this commit: https://github.com/torvalds/linux/commit/73f7b171b7c09139eb3c6a5677c200dc1be5f318
> Starting from v6.3 kernel and we have to fix this in 6.1 kernel as well, so we have backported this from v6.3 kernel version to v6.1 kernel.

This change was already backported to 6.1.y and released in v6.1.52?

It is commit 179c65828593aff1f444e15debd40a477cb23cf4 .

Regards,
Salvatore
