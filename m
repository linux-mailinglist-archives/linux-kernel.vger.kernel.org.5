Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810F7B2088
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjI1PJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI1PJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:09:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4B194;
        Thu, 28 Sep 2023 08:09:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EEEC433C7;
        Thu, 28 Sep 2023 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913760;
        bh=oh808DVw8eOQZT9DfCsp2ZukXXSSMvbMKkxP52OYxec=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TtMzWc5VA2OFCfw2jd7iAixAH2L4nWRdKRANRDB78+QkcS6MWknD0GnCoecy5sc0o
         UWIdq0QPKmpBUAPtVxmc1RXA73rJwtMDpr0mctx+HRZHQavACuTZ32yWBt9urVrxH7
         hAYOVJQlizRKkoH0aXKi2sISJjh8/5IV5g3uKpeakzJMBvhAQ90eci/C2D+lhv85Y1
         K6N4Uiq6dBg99+hW08cgMy7wntvRIG4AEbRD0H3lFPUMlIbBXc2GZYTKYmF2lpaZxQ
         CK18a2zda1dqscdXJFabBKU+f6nl87T2VC1xGdkQcsPkNK6Y0kB0jsqG8U9Qcxd3FG
         CmhDck98V1ccA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 wireless-next 8/9] wifi: ath11k: remove unnecessary
 (void*)
 conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919045150.524304-1-yunchuan@nfschina.com>
References: <20230919045150.524304-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591375653.3019228.16747034733497698800.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:09:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void *) to (struct ath11k_base *),
> struct hal_rx_msdu_link *), (struct ath11k_buffer_addr *) or
> other types.
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

87fd0602610d wifi: ath11k: remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919045150.524304-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

