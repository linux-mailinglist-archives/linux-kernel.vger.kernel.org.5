Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118F80F424
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjLLRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:12:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB25CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:12:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF99DC433C7;
        Tue, 12 Dec 2023 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401163;
        bh=11KCF6eSfX3xll38pRiWQMZTkETjMhw6UMQe+oezm78=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JUaoRgfnbG3rvgefKvEPEIVdTLPOtFJN5zQ42Fh1q7LwJIk11bBtG/fSym3OaFS4X
         8qyGvBj+NLb+mcwzSbuOghxn6a9l/E5Hjv4Mi0G/p4rhyO6uD/9tkPVNH+d3dmsr0k
         PTbIPFnx9NrjdRdWQdSQARv5GU1EGVDRIYd3Cj80kKij6aOSPrV8btNNt1aD/Lnodx
         crc1c/nXU+NB4z8CNtz4cw5j0dDOXZDbnj3z1DAZjjidn5czF/Quhz6VtG2ZGtzGyo
         NxBn+VjFRyk7xqKDamf6cq0qZDZhVUVbCawrLU39Qba21U14d+rpiEjYwuYV+Pd1AJ
         oQz4W6NGLcBmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170240115970.422537.17165398794556525510.kvalo@kernel.org>
Date:   Tue, 12 Dec 2023 17:12:41 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Transform the zero-length ath11k_htc_record::credit_report array into
> a proper flexible array. Since this is the only array in
> ath11k_htc_record, remove the unnecessary union.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

add731385eed wifi: ath11k: Fix ath11k_htc_record flexible record

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

