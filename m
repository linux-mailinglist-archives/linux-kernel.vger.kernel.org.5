Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE647658F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjG0QkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjG0QkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:40:07 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715230F9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:40:00 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 61DEB240028
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690475998; bh=092WwDpn2i4avpEQ13hzD461gGd+m6aVrqr7HZMYW8s=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=oJ1r6aY6sJyL9UdBgULTw/aIRFiGMbWGTwjnmgHNELlMXlPr3s18wLYihWCbB48yI
         kOSqBF2lo1kEPaQaHI35AkXqz7DwRYormaIZhRKXwML1LHYcCd34y52BDljBc7QsGy
         q7XMv5/e+hVMtLm4WSDGU8lAWt/AC6hh3HEvXqzW0p5DSN7+KHgCOezfMhAF8TABdm
         PL5UjPM2uY/cdHE5Bq9hjFyqT1Sk+FM5quTxuNAo1u4lLIbRJiN//hPK0l3Y6bNY5l
         MHy9ihQhx+Tf+A29bIsB5vBhGORRqPV4AOOQLj91FbC+HUZrorK87HHHf+IXEhzFf7
         AFm7pQgwM3+bg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBc1m4FcTz9rxF;
        Thu, 27 Jul 2023 18:39:56 +0200 (CEST)
Date:   Thu, 27 Jul 2023 16:39:49 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230727193949.55c18805@g14>
In-Reply-To: <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
References: <20230727183805.69c36d6e@g14>
        <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 10:42:33 -0500
Mario Limonciello <mario.limonciello@amd.com> wrote:

> On 7/27/2023 10:38, Daniil Stas wrote:
> > Hi,
> > I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
> > laptop.
> > Compiling kernel without TPM support makes the stutters go away.
> > The fTPM firmware version is 0x3005700020005 on my machine.  
> 
> Can you please open up a kernel bugzilla and attach your dmesg to it 
> both with TPM enabled and disabled?
> 
> You can CC me on it directly.

There are several bug categories to choose in the bugzilla. Which one
should I use?
I never used bugzilla before...
