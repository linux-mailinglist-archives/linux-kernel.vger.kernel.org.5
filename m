Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735C7BE7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377431AbjJIR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjJIR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:28:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3451CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:28:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA65BC433C7;
        Mon,  9 Oct 2023 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696872492;
        bh=MowmknSIgoec/jnZ1c8AvJVgCudW81aa5TiSZXSftyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3GoBgqBbCbC+ciFFIn4UcCHY7e6XV523Rin7WfS5a6Dmc0aNsiOIlOPtXWuwKlM2
         wSFZijkYNj3s7S7y7RGO8DGtHVgX/CYk/PdKs2OQ4z+rQsrqiypVoAD2/qmlZBPQ3v
         lSPhtsKV+JSnWRibGSGGpPNUifgCg7qCOhL634TM=
Date:   Mon, 9 Oct 2023 19:28:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] drivers/extcon: add local variable for newly
 allocated attribute_group**
Message-ID: <2023100957-whole-hurling-1e6f@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-3-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-3-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:36PM +0200, Max Kellermann wrote:
> This allows the compiler to keep the pointer in a register and
> prepares for making the struct field "const".

Again, registers have nothing to do with this.

thanks,

greg k-h
