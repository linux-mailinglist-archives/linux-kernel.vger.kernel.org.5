Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE47BBA00
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjJFOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjJFOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:12:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157CCF;
        Fri,  6 Oct 2023 07:12:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A6AC433C7;
        Fri,  6 Oct 2023 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696601527;
        bh=W8T8/kn6nOnCi47BvSU3UPd5pajVYNfSAYkFoseDTvM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KgviZjvUz8fDz4vKM9icf1PH4NUbznGzDmj443TXG6EmWUR/Oqfy0eyidyq7vuihT
         X6IIOueAvo64dLdlARg/vPmNT5slnguyN4Su3yLP2ROO4Z78E8VULuUnKxbdfZFTcI
         HZiMJ0cKuEmG9GyHHbu3w3X0Z48HC2KL3oG3SQ9UnUCU08wewLhXweTSklAZ8vedFS
         Wtz6h3TE/xFUmnpOyRWKYA6s03YAmqUe29vk8BXuTf8mMHm0qPvXlnhk2A3LlkKGgm
         xH6S4s2q3nnUF6NI3GSYfMnjjnY+ygfIpuN1kbrkOvVEp5PHcvVFG4sjWyBKaTmvMJ
         TVMOXqTHGGzQQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20231002155857.24584-1-johan+linaro@kernel.org>
References: <20231002155857.24584-1-johan+linaro@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: fix handling of unpopulated devices
Message-Id: <169660152573.2015335.12847604884755165394.b4-ty@kernel.org>
Date:   Fri, 06 Oct 2023 16:12:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 17:58:57 +0200, Johan Hovold wrote:
> A recent commit reordered probe so that the interrupt line is now
> requested before making sure that the device exists.
> 
> This breaks machines like the Lenovo ThinkPad X13s which rely on the
> HID driver to probe second-source devices and only register the variant
> that is actually populated. Specifically, the interrupt line may now
> already be (temporarily) claimed when doing asynchronous probing of the
> touchpad:
> 
> [...]

Applied to hid/hid.git (for-6.6/upstream-fixes), thanks!

[1/1] HID: i2c-hid: fix handling of unpopulated devices
      https://git.kernel.org/hid/hid/c/9af867c05b5d

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

