Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08597BC8B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjJGPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjJGPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:41:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975BB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 08:41:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692c70bc440so2567574b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696693301; x=1697298101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk+ZMtU5f7x0KSV6yTAKp1YLFSinobCi/p1pfUDzEYU=;
        b=BtgQcFuXcf9b1jM74w/oT8C0ui9CUh9atnFRCFvpkJm1uRFcSZjfG70lzqkndUWN3l
         C63PK82JfxBb6oXx0YTsvCS3m5P0jhURNIrIAmtlRscR7uZEENqhS0UHUqDc/R/Sn69o
         XaxlrJFcgtpxZU1dDYPtdgQRUvF5cguP0ORdjgYcRDNXBXiDKkwkO/PZFyKcIlqmaPrr
         J3jeRirB7Vq2+VTJqM+TZG1uzlwQ6x2S5V0HoJOl634Mb1UofjyaavuWUpBEgqlqamsX
         wblv9LnEyPPLBC3oi1J26IP7l2yjMFTZvcncKVGZOt1Xc9fqba7QsOp4uo6t4pJbdQYy
         JUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693301; x=1697298101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk+ZMtU5f7x0KSV6yTAKp1YLFSinobCi/p1pfUDzEYU=;
        b=TQ2FbR79kJcMy34/GUF2smvoL0QztdzRXTCSwWXVE197fygwKcDYZ3KpcwPGIvv+eT
         u4RzA2xYZOkM6I5YCLpAgiu6z2JIlrYT2y6Fl43uaDkdCJpRtVB9FoAukoZ4RxHFeKjM
         T3AbTFcSTJD6vfXfz8V9MaOiAZ18zNj40OZCsZrJPhEZlmX7apWFkq9q4YHoVwOemUou
         5s9H7VR6AjoOBWNd/Roq2nfYbnScPP5YG9PGHUcTZqoATbJTpNg1LD4mSiOTPMNlqRsT
         gVSxNpqfxuU+mbuZPI9YExFSSft8oMHZ3muGSItzWa9drh5x9uL1VJeofnDExX4lz217
         tCXA==
X-Gm-Message-State: AOJu0Yx6wf5JJrADpSt4KSb1dEwu1blyj5dBoHA30Vw3wmfo9tvzuI3G
        jZRRm0FczW2HxONTSkwcYYA=
X-Google-Smtp-Source: AGHT+IHJFW8TpttB1Nmg7aTMpG7TEprqJ+S1YH3qz0mFr/JyLM2htqKpbbzfc5TVpWtDLhb7sfbMwg==
X-Received: by 2002:a05:6a20:9146:b0:15e:dc75:66af with SMTP id x6-20020a056a20914600b0015edc7566afmr12462033pzc.59.1696693300913;
        Sat, 07 Oct 2023 08:41:40 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:f940:d30d:8b60:5b64])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b00686b649cdd0sm3317539pfd.86.2023.10.07.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:41:40 -0700 (PDT)
Date:   Sat, 7 Oct 2023 21:11:35 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     stefani@seibold.net
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kfifo: Fixes a typo
Message-ID: <20231007154135.GB20160@atom0118>
References: <20230817173636.78757-1-atulpant.linux@gmail.com>
 <20230923173157.GB159038@atom0118>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923173157.GB159038@atom0118>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 11:02:02PM +0530, Atul Kumar Pant wrote:
> On Thu, Aug 17, 2023 at 11:06:36PM +0530, Atul Kumar Pant wrote:
> > Fixes a typo in a comment.
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  samples/kfifo/dma-example.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
> > index 0cf27483cb36..112b0e427199 100644
> > --- a/samples/kfifo/dma-example.c
> > +++ b/samples/kfifo/dma-example.c
> > @@ -80,7 +80,7 @@ static int __init example_init(void)
> >  			break;
> >  	}
> >  
> > -	/* put here your code to setup and exectute the dma operation */
> > +	/* put here your code to setup and execute the dma operation */
> >  	/* ... */
> >  
> >  	/* example: zero bytes received */
> > @@ -109,7 +109,7 @@ static int __init example_init(void)
> >  			break;
> >  	}
> >  
> > -	/* put here your code to setup and exectute the dma operation */
> > +	/* put here your code to setup and execute the dma operation */
> >  	/* ... */
> >  
> >  	/* example: 5 bytes transmitted */
> > -- 
> > 2.25.1
> > 
> 
> 	Hi all, can someone review this change ?

			Hi all can someone please review this change ?
