Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1E777D889
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjHPCrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbjHPCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:46:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F8212D;
        Tue, 15 Aug 2023 19:46:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdf98a6086so10890685ad.0;
        Tue, 15 Aug 2023 19:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692153999; x=1692758799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFHDzNzdtlkQkQP+fhEZRdRVhM/XmcV4b9LbBATyDdQ=;
        b=EyPPRLWVWWPkgvGCB2nDeGsfT8neZuQiwLCZfox5vAZGW4t1YXLuCeUagBiVlS4zbv
         /LvfcJZX0ZMqGavTctydeiMuopwRugk27yGNHz4s5j051X6vkWAAE5vwVLfaeVccdas1
         0UYn8deeoDgYjJ2uKp64sCqZQTZD9G825QzHK4f+JRYAWw3qFoU1SEha6To06o8a6HTe
         cDUgcbTotIAWDxrbjNfl0HPUuhKyf6hVF3WL6oaN4ObHp9Qu+BAlIlxy+QW4BmTvi1cM
         XqP74njZA14EWlNWtwXt7mNEFj5fcKKdAQAwyBWWGiDRZ9vu6160c+SA9z7xrRTrdD24
         SrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692153999; x=1692758799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFHDzNzdtlkQkQP+fhEZRdRVhM/XmcV4b9LbBATyDdQ=;
        b=Vpsciy6F7oUPD6IHVZxlXrP/p34Mo33BrOFf0sw4HGkX9Wir898QrMvLjrcNccdJe3
         qV5omrDnSKFzH1J+UAk+iaIhpuRGckPMuOk7MAWe9h/dGJdE7UjYbf865ybLl5gLCUF1
         Ae7U/M5JlkD++i6MEOxd0cOpG7h/aa2CPYAutvtfwKIUMhMWUk+9+N8G1w3+NelcwDR+
         aQE6KYglQeGSXgEHGkVtggG34Dl9RKf+8BX5FEt+bgOOEkO5yc7V02Szhqa74Sgg2JKl
         piFU28BsOryi4RKoQBiduRzLTgzFLv8wrSgKYI7xU/24mI7K/4/Otkpu2y2/w3+ZBbFJ
         ENSg==
X-Gm-Message-State: AOJu0YwlHK2SCBm8QRL9dHPh68piPKImjU/21G/ddxc6L7OlaWMFcEcI
        0n9Lpzn/EnJt3wPZgDmBBz0=
X-Google-Smtp-Source: AGHT+IFcg1dYEy11hbI/CWqMncjtpM2VIuz1sy7IfdZkCsHWotzIyHGNgvFDFOA0/9KEcTjf4caEAw==
X-Received: by 2002:a17:902:ec86:b0:1b8:400a:48f2 with SMTP id x6-20020a170902ec8600b001b8400a48f2mr702360plg.62.1692153999090;
        Tue, 15 Aug 2023 19:46:39 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:6a8f:3187:b8c8:1572])
        by smtp.gmail.com with ESMTPSA id nu12-20020a17090b1b0c00b0026b6d0a68c5sm2490209pjb.18.2023.08.15.19.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:46:38 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:16:32 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, bagasdotme@gmail.com, raychi@google.com,
        f.suligoi@asem.it, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] drivers: usb: Replaces spaces with tabs for
 indentation.
Message-ID: <20230816024632.GA57274@atom0118>
References: <20230815204439.52137-1-atulpant.linux@gmail.com>
 <2023081515-glove-grub-96b0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081515-glove-grub-96b0@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:08:02PM +0200, Greg KH wrote:
> On Wed, Aug 16, 2023 at 02:14:39AM +0530, Atul Kumar Pant wrote:
> > This patch fixes following checkpatch.pl issue:
> > ERROR: code indent should use tabs where possible
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  drivers/usb/core/hub.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> You didn't mention "hub" in the subject?
> 
> Again, please start out by doing work in drivers/staging/ to learn how
> to write good patches, before venturing out into other areas of the
> kernel.  Fixing up whitespace issues in random kernel parts is not
> always encouraged.

	Sure Greg, I'll check /drivers/staging/ and will avoid doing whitespace
	changes in random kernel parts.

> 
> thanks,
> 
> greg k-h
