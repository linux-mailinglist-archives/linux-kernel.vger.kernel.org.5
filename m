Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8D7D2DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjJWJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:08:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6298;
        Mon, 23 Oct 2023 02:08:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24111C433C8;
        Mon, 23 Oct 2023 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698052131;
        bh=jwRsyL0IKugyJxiMd8kLsgpJe00BKc6ZBp9nnsSKdh8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fYhWq3tMJe5ZmbkFSfJ7QJdxNCXC3N996oh0H9CZpO/zYTlGkS9yuOamWKbktfKoG
         ObjHvauvkniDP+f/fk7s47NMI7wwQOQGVFQWv2/JfWAyEH6mGFARenFYfm+QMfZ36M
         20DZ4zdLoadEbR373pJFoYwBzFIVTlrKwV4CmSk4aggq+KSYJ5/idMRTKCT5oZmnvl
         Dm90Jz3OcYwpFPHOwtzZAqUV66OwRzYe7fvGm6bn0kaoR0BtKDOTOtT0CD4G7cnKQn
         VyhHT5ZGOafX0kngTAPkYN6kJTeUc+CZgKB+rK7xxXHGeuvNVkfwSPRvFu3d13dAye
         Wpu3S9cuZnBoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     gregory.greenman@intel.com, johannes.berg@intel.com,
        mukesh.sisodiya@intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: Add check for kmemdup
References: <20231023064501.274599-1-nichen@iscas.ac.cn>
Date:   Mon, 23 Oct 2023 12:08:48 +0300
In-Reply-To: <20231023064501.274599-1-nichen@iscas.ac.cn> (Chen Ni's message
        of "Mon, 23 Oct 2023 06:45:01 +0000")
Message-ID: <87zg09zowv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Ni <nichen@iscas.ac.cn> writes:

> Since the kmemdup may return NULL pointer,
> it should be better to add check for the return value
> in order to avoid NULL pointer dereference.
>
> Fixes: 5e31b3df86ec ("wifi: iwlwifi: dbg: print pc register data once
> fw dump occurred")

The fixes tag should be in one line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
