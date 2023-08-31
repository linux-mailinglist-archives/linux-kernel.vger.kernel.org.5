Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8A78F187
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjHaQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346589AbjHaQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:56:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455CE50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso7816325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693500983; x=1694105783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FffvsGWG4o/+MK35eQ6fKF+ifwU5eNn4Zb6qXJqhIH0=;
        b=D7WAcDRyOxtFfBumxEXrj6Tgygg6nU+EtvMJ/olMxsqpHxA8kD3WbXdrOlMlyHj/+M
         vvHLhspGrr9vBGGduTas3oD0yaGIIPjyRqzjbQXALl9yEaBVH9lrBZFvrPuVI/PcgZMW
         rkfdzWEWyBwM1lBL/Qvc0nmStlfFExApbvXvBdzF4FLsdongdkiqsZlgWVNi6zgu2zn4
         HH23jdBcUarfZH0EEi3W8Xfv7p05rxR8p1ozwj9YVijqZxpZy3b11Pj3ibLT0IBVBrfT
         2QgfW9+eVSby0t3aNym1lq7L1n92COYBFuM4t8UNDwk12tTahVY1mIvkLbVy9UUxm4ZA
         K9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500983; x=1694105783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FffvsGWG4o/+MK35eQ6fKF+ifwU5eNn4Zb6qXJqhIH0=;
        b=ZuqFf/DZS1EvkzKqtD4wUDCq8ZyV9aTRC1KIHV1W4sAnkJ1F9WY7MhFUdOwcsfJior
         dMQdb+ixPHzL4IXy4ht9iu0gdHYiGi1Mk5vXwO0eLLYJeAuCzkqgghh2V4nAs5XoUztY
         9fhlvjh/NQl3B/CozCpPiwtVr0QtztH96HF7f3x1Qk0+fOcoE2iDmkNBLYxTxho97Izj
         dP8+gZqpZyQZP00Ae4fjiFiu+26kFLVskthsHRsAWSYLSzvbRYqd+4AoVtpJ918QjdYx
         JAYEXk1mz9FoBs0jHKIrtWwJV+ZwGGp4eNxWJfeome9FRE7I++3gsgTDBZ1JeO6NEEmI
         Z+5Q==
X-Gm-Message-State: AOJu0Yzt+rvabZYSgo6wqf2sMVuJ3P79bq4NG/vKUP1St6L+ej2bn4A4
        //qA8CTSJY7PBxLpd8iKvaxfPw==
X-Google-Smtp-Source: AGHT+IEDI82NNXCwkshM+WujgWXe/Jzh4lytCdzF/QQCVfGPB/aRcv+Fr0DY8KJZhMpGMHpYM4uDYQ==
X-Received: by 2002:a17:90b:4b0d:b0:271:7ce5:2575 with SMTP id lx13-20020a17090b4b0d00b002717ce52575mr5041222pjb.22.1693500982856;
        Thu, 31 Aug 2023 09:56:22 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b0026b4ca7f62csm1666361pjl.39.2023.08.31.09.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:56:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbkxv-000IS8-9F;
        Thu, 31 Aug 2023 13:56:19 -0300
Date:   Thu, 31 Aug 2023 13:56:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZPDGM2YWvTAhk4tE@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
 <ZO+oRPOf9jyNG2+B@ziepe.ca>
 <20b44fe8-33ba-d6ae-110e-a82a19390bcc@amd.com>
 <ef751928-7123-6840-f080-ca63e24e5ece@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef751928-7123-6840-f080-ca63e24e5ece@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:35:36PM +0800, Baolu Lu wrote:
> On 2023/8/31 14:42, Vasant Hegde wrote:
> > > > Also in this function (mm_pasid_drop()), should we check/free sva domains?
> > > No, the driver must support a SVA domain with an empty mm_struct, eg
> > > by hooking release.
> > Sorry. Looks like confused you. Looking into code I got this.
> > 
> > My question was: when PASID is enabled, is there any chance of mm_pasid_drop()
> > getting called before freeing all SVA domains?
> 
> I remember we have discussed this during sva development. If I remember
> it correctly, in any case, mm_pasid_drop() will be called after the
> device is closed. 

Yes, we guarentee this because the SVA domain should be holding a
mmgrab on the mm_struct while it exists. The mmdrop cannot happen
until the SVA domain is freed which puts back that ref.

But drivers must not make any assumptions about this, the lifecycle of
the PASID is a core concern, so long as the driver is asked to attach
a domain to a PASID it should assume the PASID is valid.

A driver should *never* look at the mm_struct PASID, all the examples
of this in-tree today are wrong.

Jason
