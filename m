Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049997D73C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJYTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:01:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483C8195;
        Wed, 25 Oct 2023 12:01:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BEC433C8;
        Wed, 25 Oct 2023 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698260493;
        bh=cqpNLxz8QEJ10N9YfPvQwxHo4wYWmPCwAExeIfzZku4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oNnDSGbZgeOKtnZPz02wgvr7xlTPSdbewbHLDaI3iNXWB3jUzAPT3QHtEuRaVemYj
         yWmrvfz73TYLTO37Jsg9eeBpTCiEXux7zpx+ltlPUjrYLFBCYF4uaN7/ERRDvdjdng
         02py9nJro2mhHDoPw6M0ALY6aH3NbIaHoIwF4aaZk0vWTX4vz+SCtTMX+1V9ItZ+u+
         DvVY1PDiD9Lqu5YpZxbBQKCTQJ2kZE/2PR1Sxg5zEJtG1lGS8YxmcC8W+B9o1fub5V
         RWuDnuUG/5w/cxeoVpsqUiX4OEi8mqH8z8iF0MVzxElofEmxwsRctY4tYEf7hVx56y
         OsTlLRZ2RieCg==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com, jm@lentin.co.uk,
        linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Cc:     linux-input@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20231002150914.22101-1-martink@posteo.de>
References: <20231002150914.22101-1-martink@posteo.de>
Subject: Re: [PATCH] hid: lenovo: Resend all settings on reset_resume for
 compact keyboards
Message-Id: <169826049199.324677.14789310817428601000.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 21:01:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 15:09:14 +0000, Martin Kepplinger wrote:
> The USB Compact Keyboard variant requires a reset_resume function to
> restore keyboard configuration after a suspend in some situations. Move
> configuration normally done on probe to lenovo_features_set_cptkbd(), then
> recycle this for use on reset_resume.
> 
> Without, the keyboard and driver would end up in an inconsistent state,
> breaking middle-button scrolling amongst other problems, and twiddling
> sysfs values wouldn't help as the middle-button mode won't be set until
> the driver is reloaded.
> 
> [...]

Applied to hid/hid.git (for-6.7/lenovo), thanks!

[1/1] hid: lenovo: Resend all settings on reset_resume for compact keyboards
      https://git.kernel.org/hid/hid/c/2f2bd7cbd1d1

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

