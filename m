Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8033C7B985F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjJDWsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjJDWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:48:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0A90
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:48:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-69101d33315so269567b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696459708; x=1697064508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+A41qc5nnmnXCGqzGK/2/pzW8O1/gqRl39Ug/MmsPjY=;
        b=k04h216BWDygbKaOY92AakISD4ZjtzPmUdiyg+0v6kZZdAgcbedC5zjHM/KOiNGGMv
         ZY43AwHTXutqIkxE14K0BJwfp22ZjZqVLPYbeF6hxDovxr71k3N/Wi9nIgmm56Mqcfdj
         0rQbnpADW1bOs9DnwdWAnJWIdMm2UmIaesPpuxvAGu8EuWQUIsioZuOJrb9lNUkeFu6p
         W/Eh9AL0MhD/qYc0ydlX1rAL3/iaC0XORBeerCOB4rMMMYjLGa18j61u0rV0k3CSNxpD
         1VEsO7cFnyRSRY+1EUare54vimTaLYtlhl4yClKdH9/DfEStcvK0N8JhzXAOUTfV0AUB
         bplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459708; x=1697064508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A41qc5nnmnXCGqzGK/2/pzW8O1/gqRl39Ug/MmsPjY=;
        b=qvSYtC5vEkO8UYdj9bhHk8KgavuA3mzLeJOG+XSl+j2YE6HnoKRg3aA3MWEQTveUBW
         1SAhkIHcOkEGVq1NhZ2SmjIKOpQJUZ7ablCGamlbupfEGDCwAzML183uCfFTFMOXyH/u
         jcDCWUR+FNmIAaGifH+Vi5OG424K+cV3nLYatxNMFNUW98u+TRscX62eZgd2Ms6YIzp5
         wVGdr3aKO4nst4s0HzlTITmwiYKrwyR4cWqTOcW2WBlxb884Zc4JIxzlgosDS3OcSBUi
         RNc5tNNO+1nDoTPZz3ohCatkFVEa7Pk51FomghO9hcYLXVyhPNb5S8oAsHjdy1OeTpim
         VinQ==
X-Gm-Message-State: AOJu0YzngzghomsU9QxsZ5oha3lPUVXRPdh/XPOVD3U9yeo7gFplLaCP
        rVXxBOPAr5arYbTaADFJcOsZVQ==
X-Google-Smtp-Source: AGHT+IHTMmCgJaPPPebL/z6ptP+ioTw9on4mYiswrAi8Kcue6f5UNTVBPQhGJAi31/XYj6jO6KbLMg==
X-Received: by 2002:a05:6a00:2406:b0:690:d620:7801 with SMTP id z6-20020a056a00240600b00690d6207801mr3836132pfh.11.1696459707926;
        Wed, 04 Oct 2023 15:48:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78056000000b00692b6fe1c7asm32069pfm.179.2023.10.04.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:48:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qoAfI-009Wtm-33;
        Thu, 05 Oct 2023 09:48:24 +1100
Date:   Thu, 5 Oct 2023 09:48:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        djwong@kernel.org, himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <ZR3ruIg5tpKSG0mp@dread.disaster.area>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <9ba10b14-931b-42db-b7c2-e6f9aa95e477@acm.org>
 <dee45e9a-6a45-e949-2b46-1373fea8dcda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee45e9a-6a45-e949-2b46-1373fea8dcda@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:47:24AM +0100, John Garry wrote:
> On 03/10/2023 20:25, Bart Van Assche wrote:
> > On 9/29/23 02:37, John Garry wrote:
> > > +.BR RWF_ATOMIC " (since Linux 6.7)"
> > > +Allows block-based filesystems to indicate that write operations
> > > will be issued
> > > +with torn-write protection. Torn-write protection means that for a
> > > power or any
> > > +other hardware failure, all or none of the data from the write will
> > > be stored,
> > > +but never a mix of old and new data. This flag is meaningful only for
> > > +.BR pwritev2 (),
> > > +and its effect applies only to the data range written by the system
> > > call.
> > > +The total write length must be power-of-2 and must be sized between
> > > +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both
> > > inclusive. The
> > > +write must be at a natural offset within the file with respect to
> > > the total
> > > +write length. Torn-write protection only works with
> > > +.B O_DIRECT
> > > +flag, i.e. buffered writes are not supported. To guarantee
> > > consistency from
> > > +the write between a file's in-core state with the storage device,
> > 
> > It seems wrong to me to start the first sentence with "Allows". Atomic
> > behavior should be mandatory if RWF_ATOMIC has been set.
> 
> Yes, I agree that this has been poorly worded. Flag RWF_ATOMIC does not
> indicate anything. I will fix it.
> 
> > 
> > Additionally, shouldn't it be documented what value will be stored in
> > errno if the atomic write has been rejected?
> 
> So I was treating all atomic writes errors which don't follow the "rules" as
> low-level I/O errors, which is -EIO. However, yes, I can document this.
> Further to that, based on description of an error for O_DIRECT, which is to
> return -EINVAL for misaligned, I think that -EINVAL may be better for any
> atomic write rule violations. OK?

Agreed - I was going to make that comment myself about using EINVAL
instead of EIO...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
