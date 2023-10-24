Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3A7D5859
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbjJXQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjJXQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:30:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6493;
        Tue, 24 Oct 2023 09:30:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E012C433C7;
        Tue, 24 Oct 2023 16:30:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, arnd@arndb.de, Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2] arm64: module: PLT allowed even !RANDOM_BASE
Date:   Tue, 24 Oct 2023 17:30:05 +0100
Message-Id: <169816491209.2944710.1720191649238915264.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024010954.6768-1-quic_aiquny@quicinc.com>
References: <20231024010954.6768-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 09:09:54 +0800, Maria Yu wrote:
> Module PLT feature can be enabled even when RANDOM_BASE is disabled.
> Break BLT entry counts of relocation types will make module plt entry
> allocation fail and finally exec format error for even correct and plt
> allocation available modules.
> 
> 

Applied to arm64 (for-next/misc) with Mark's commit log. Thanks!

[1/1] arm64: module: PLT allowed even !RANDOM_BASE
      https://git.kernel.org/arm64/c/d35686444fc8

-- 
Catalin

