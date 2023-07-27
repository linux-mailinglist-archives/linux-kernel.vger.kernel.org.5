Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686F77657D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjG0Pi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjG0Pi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:38:56 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B175269E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:38:52 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A6FD924002A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690472329; bh=+5Y7A+eOCq0ACs87IHElqsQj43DliFjmkVu7op/eH6k=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=fkB/4KjTpoV6o+9EacCJUp6zLujion+KMTjWKNDNGsRKQa+8klnPaKtmyoNTH9ADa
         cP7P5czvMnG1yLpgfH3xxcrL/fEDOK+vzlok2SfDY2+ulHV/yLcpd1rizP5HIb7wYC
         GkI8C5qbsKL+CWVYEvTrBZmV+H6Faw7J5N9E6wL2YxQRlh2gmyNycD+HA7ajSNJoQv
         khTEDPy8bMGhoS2Uu/UhnpN+wOOput8aeXnk0vv2XCez30i/eWb00LQRD+foaCfye0
         QtZ8DmwU0Q6kTljkWsLCvm9MhqK0HA+i2rCJfv/Q6EWZ+iX5fVXp+OjT+RFi1kDDVi
         EEav5nERJtA7A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBZgC4Kbkz9rxV;
        Thu, 27 Jul 2023 17:38:47 +0200 (CEST)
Date:   Thu, 27 Jul 2023 15:38:05 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     mario.limonciello@amd.com
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230727183805.69c36d6e@g14>
In-Reply-To: <20230214201955.7461-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
laptop.
Compiling kernel without TPM support makes the stutters go away.
The fTPM firmware version is 0x3005700020005 on my machine.
