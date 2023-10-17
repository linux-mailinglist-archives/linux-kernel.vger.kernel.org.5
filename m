Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919B7CC410
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjJQNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbjJQNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81753F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:11:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BF5C433CA;
        Tue, 17 Oct 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697548270;
        bh=6na3KIhoa7xyy/cyfreZSfIOVm63MWCbjoDVj0CRp84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG+OZc0A/5PcnW3jQbruyY3+4sMYgXdXNP+F/TDu5TowMNj9mmOWVhquy9SP0TrDL
         Rqy8mWemoOvUT29ZmF16/56AlPNYUg7/HemuPwZfNKo2ihC2g+FzXmbzacARMS0zA3
         0EzmnRsQ/l709ytg0fPpXqR03zJJvaCTFFtPujNiTOPddVYRrqD/fMhkUEW6nThvCW
         x+Gj7afDMW1p/H5HzVbpRfk2ucgXKEaB33+USaPXKidLr3hQ/Y5dQkMuu9LQ8re9dD
         R1oaU0SV7tY973FNQ909XR0sP8DU+zZLIrJDpHVs4jRCcJB99ysN4laHCpLVsQbhuZ
         28yvN1mX7H4ZA==
From:   Will Deacon <will@kernel.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: xgene: Use device_get_match_data()
Date:   Tue, 17 Oct 2023 14:11:00 +0100
Message-Id: <169754299431.1685945.7908215672688092746.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231009172923.2457844-14-robh@kernel.org>
References: <20231009172923.2457844-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 12:29:09 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() and
> acpi_match_device() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: xgene: Use device_get_match_data()
      https://git.kernel.org/will/c/1f33cdef8ca1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
