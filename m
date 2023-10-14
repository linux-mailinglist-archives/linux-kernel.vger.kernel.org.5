Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5A7C9348
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJNHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:39:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1ADB3;
        Sat, 14 Oct 2023 00:39:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7bbcc099fso35776867b3.3;
        Sat, 14 Oct 2023 00:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697269183; x=1697873983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3pfyKY5IaoFuTuLVntmNnqtU1SUqO73JEN0YvBTiXE=;
        b=SdtIzRSngbDs7E0rP8faZ+PDnoHk3mznG1rAaaPw+OASvSG5z3grZj5lEruvIBS5Fx
         or/umvCf/WWMYOhQTMR2Il3PCJB0zsSHhTXcXqrNMOjzjMWqieCWXfkg1+pxPEVGLqmg
         7ZnktwaiYWNeb+argnfMHr8SWGyTymAnUgDnc1R+uf0JF8cwJW2otGkZunAsphF1Hfv6
         GuzUmpw20urdwXl0VMgNOJHshxckQmupqq0zAxhdzJE1GnIPq7N8a12HRXoxMzlJ2AUF
         GJGAPOhkWUNYwOMy4RRoo7IR3O20Sz5OVSD1IsHY0OmuFuk/+KPLtRxxN8am/Tb9dj8C
         GZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269183; x=1697873983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3pfyKY5IaoFuTuLVntmNnqtU1SUqO73JEN0YvBTiXE=;
        b=PuKlazZ6kJ5NxCifid51GINXjHx1jXoCSPEazuOOKI1x+DWUtYvKwSJK2lxpStSHy4
         +sfpddqZM/+3YADn0gA1CffBkhOQ37ylWfeuSditkw7D4tHIKjwNr9d84BMrvf/ItRas
         mbIrZuaznq3d30JbQlxGDWWS6Bp9ep49K1PYcS2YYr7DV3XZjavNbtmldMDjorsN0u/F
         pn1eOlDc/zEUlgIrV9UzHKubAfmQ/iyX54oZv7clKFG6RSZRZ6ihpsH8R8ZrfB+QiBNX
         +QoNRa7gNENhOf0+3zJZ/Thlti3BmrRb+r365UeWaCzak7OQt7oHj8hHPB109fh8yXcN
         9Q6Q==
X-Gm-Message-State: AOJu0Yxqwl5lyT8XhVRJMNO71DprBGet4b1c5oG0D4W5G3N4G/HuIQhB
        Mfe9q8VwAVpalPqv5iR3030=
X-Google-Smtp-Source: AGHT+IFLBBfUUgNr6LViOF1jpi5Iia8QBECN3q2/onj7OgNd1yfaPOAeXkVgoQpt6phF2TPyemePTw==
X-Received: by 2002:a81:a546:0:b0:592:5def:5c0d with SMTP id v6-20020a81a546000000b005925def5c0dmr31356836ywg.45.1697269183527;
        Sat, 14 Oct 2023 00:39:43 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id w3-20020a818603000000b0059c8387f673sm394202ywf.51.2023.10.14.00.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:39:41 -0700 (PDT)
Date:   Sat, 14 Oct 2023 08:39:34 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <ZSpFtrC5xuYzgZhw@gilbert-PC>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <alpine.DEB.2.22.394.2310140819450.3383@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310140819450.3383@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 08:23:13AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 14 Oct 2023, Gilbert Adikankwu wrote:
> 
> > Reported by checkpatch:
> >
> > WARNING: else is not generally useful after a break or return
> >
> > The idea of the break statements in the if/else is so that the loop is
> > exited immediately the value of status is changed. And returned
> > immediately. For if/else conditionals, the block to be executed will
> > always be one of the two. Introduce a bool type variable 's_sig' that
> > evaluates to true when the value of status is changed within the if/else
> > block.
> 
> The idea of the checkpatch warning is that eg
> 
> found = search();
> if (!found)
>   break;
> else do_something();
> 
> is equvalent to:
> 
> found = search();
> if (!found)
>   break;
> do_something();
> 
> Because now the normal computation is at top level and the if branches are
> only used for error handling.
> 
> But that is not the case in your code.  In your code, it seems that there
> are two cases where one would like to break out of the loop.  The code
> would be better left as it is.
> 
> julia

Thank you for the quick review. I thought about it the you described but
then realised the else was not redundant that was why I went the route
of trying to suppress the warning. I will revert the changes as you
have suggested

Gilbert
> 
> >
> > Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> > ---
> >  drivers/staging/qlge/qlge.h     | 1 +
> >  drivers/staging/qlge/qlge_mpi.c | 8 ++++++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
> > index d0dd659834ee..b846bca82571 100644
> > --- a/drivers/staging/qlge/qlge.h
> > +++ b/drivers/staging/qlge/qlge.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/types.h>
> >
> >  /*
> >   * General definitions...
> > diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
> > index 96a4de6d2b34..44cb879240a0 100644
> > --- a/drivers/staging/qlge/qlge_mpi.c
> > +++ b/drivers/staging/qlge/qlge_mpi.c
> > @@ -909,6 +909,7 @@ int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
> >  static int qlge_idc_wait(struct qlge_adapter *qdev)
> >  {
> >  	int status = -ETIMEDOUT;
> > +	bool s_sig = false;
> >  	struct mbox_params *mbcp = &qdev->idc_mbc;
> >  	long wait_time;
> >
> > @@ -934,14 +935,17 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
> >  		} else if (mbcp->mbox_out[0] == AEN_IDC_CMPLT) {
> >  			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
> >  			status = 0;
> > -			break;
> > +			s_sig = true;
> >  		} else {
> >  			netif_err(qdev, drv, qdev->ndev,
> >  				  "IDC: Invalid State 0x%.04x.\n",
> >  				  mbcp->mbox_out[0]);
> >  			status = -EIO;
> > -			break;
> > +			s_sig = true;
> >  		}
> > +
> > +		if (s_sig)
> > +			break;
> >  	}
> >
> >  	return status;
> > --
> > 2.34.1
> >
> >
> >
