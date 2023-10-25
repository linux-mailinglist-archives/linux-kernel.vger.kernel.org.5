Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000EC7D7166
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJYQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjJYQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:03:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1BBB;
        Wed, 25 Oct 2023 09:03:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A35C433C7;
        Wed, 25 Oct 2023 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698249831;
        bh=0RNQPWIMHfK5dOlj2x50pVv+jfpqmaYaQvFTDc1qJ7U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=KRMuIHxhjfAOd8O25rOnRbBYAG6jc3NhwUk8wHXXp5Sk28mbIo6uizmJtWdQcy0F+
         7AUJOiBT52aP0bGg3FzYRH8zUkWXnlVunX3pDLnPIfG2Iv4WkxCx0uit2m90T+bs1b
         vZJ5bl6xx+/NUcOU+l8Q0DYA4kAmDD/DP/EGfwbib45s2w0FpriLY3VRJkFXbPQWe8
         uq1xhrxaW0NvEgpy/sS3OT6e8A02jkJz+JyCZpQLzM6EW+jFJa+UiVYrn/s+x4jL3y
         bCp142c+tNtlgp2DrQZCz+4S2pjPBHU9rUm5IJx4gF85x290rbvNspdmcDRzzFmUOs
         6YVHbo66wyVgQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jose.exposito89@gmail.com, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20231009064245.3573397-1-ruanjinjie@huawei.com>
References: <20231009064245.3573397-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH v2 0/2] HID: uclogic: Fix two bugs in uclogic
Message-Id: <169824982954.180314.9509040807665756063.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 18:03:49 +0200
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

On Mon, 09 Oct 2023 14:42:43 +0800, Jinjie Ruan wrote:
> When CONFIG_HID_UCLOGIC=y and CONFIG_KUNIT_ALL_TESTS=y, launch
> kernel and then there are a user-memory-access bug and a work->entry
> not empty bug. This patchset fix these issues.
> 
> Changes in v2:
> - Use kunit_kzalloc() instead of kzalloc().
> - Add KUNIT_ASSERT_NOT_ERR_OR_NULL() for kunit_kzalloc().
> - Add Reviewed-by.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.7/uclogic), thanks!

[1/2] HID: uclogic: Fix user-memory-access bug in uclogic_params_ugee_v2_init_event_hooks()
      https://git.kernel.org/hid/hid/c/91cfe0bbaa1c
[2/2] HID: uclogic: Fix a work->entry not empty bug in __queue_work()
      https://git.kernel.org/hid/hid/c/d45f72b3c275

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

