Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C267BA221
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjJEPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjJEPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:13:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01759368A;
        Thu,  5 Oct 2023 07:35:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94E6C433C9;
        Thu,  5 Oct 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696516553;
        bh=3i/BBn71Q8/G8a7ePeWfnbBbYuk6/UEmcVUV9C07h0c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kVKlqPtsa6sjcfUw14flLGVAT43yy1cAPQfTPSQoOl8rGP0oRO6xDSYIpb1uS3mFi
         CcP1dSaN2J2KWCd/0+YL0gNTtqW46ECWHiDOG4DH9iFb99PiYhhJ9qxaQisQrD8HKv
         85nB1OUI98KeG6HXEOwqjw3ya4Z+HW3066/M2/mm7kBsyQvlrHUYeUMMw1cjtZbK7p
         jScUxEefnkntSywIhwOelpTMUDM7/aDgU0zAIvRfSZpb7s7UviFKZH0J5EuCujMFLv
         fhIVQCZs1p+Nh/QETwn2H/xT0udHkGvPz06rj3Bkjj3RHf5dVdZBNqRoyHvkZJ/YwE
         DMhz2tnrOFypw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20231002135629.2605462-1-andriy.shevchenko@linux.intel.com>
References: <20231002135629.2605462-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] leds: tca6507: Don't use fixed GPIO base
Message-Id: <169651655262.797431.9123574285135909840.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 15:35:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 16:56:29 +0300, Andy Shevchenko wrote:
> First of all, the fixed GPIO base is source of troubles and
> it doesn't scale. Second, there is no in-kernel user of this
> base, so drop it.
> 
> 

Applied, thanks!

[1/1] leds: tca6507: Don't use fixed GPIO base
      commit: ed84d55d5115455d17fa93f63dbf89697a309d6e

--
Lee Jones [李琼斯]

