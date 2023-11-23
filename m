Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94D7F5D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjKWK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:57:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A419D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:57:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF343C433C7;
        Thu, 23 Nov 2023 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737057;
        bh=1C0m0iqt2o1iTmLe2K+yT/+7q6+nm1Oz7Sg7gcJaVaM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Acfp10Yp7h+mRlKnhBlJr2fJcXXuAu96Yo6RnvYnwyzJERo0e6cLC4YSH/gXyHcI2
         XzruhLBNPjW5IQcWEDm5JPwciIDD0vzb4ktAxV7CuIEJqcL2JX2a4Tpao2g4QeKHvI
         ugzVrxtToCP72bVZ33+ze8Kbiops2IlY20snqoSp5fgqvngiX/JLiKmbZe882Le5p+
         7oeLpTdac7czH2EtLTXrtbb6U0q53+qNuCE5f9NPJg2qfyplznhnYzYlB6iTo3wbUa
         zNYwo1HsDv3ABaJjoQosoaiHqB71x2yuVVr5pIZ91QhBC2kdBY35Lq9yl4U9v//MV8
         j1vouhR6NbbCA==
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a63f3da5745187f5a9b1e2ec0492f2fe2e0b0b8d.1698854117.git.christophe.jaillet@wanadoo.fr>
References: <a63f3da5745187f5a9b1e2ec0492f2fe2e0b0b8d.1698854117.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] mfd: intel-lpss: Remove usage of the
 deprecated ida_simple_xx() API
Message-Id: <170073705658.1241275.6336543036694475269.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 10:57:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 16:55:38 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Remove usage of the deprecated ida_simple_xx() API
      commit: 1026cd156d1099e0999f060a23af7470a8530efc

--
Lee Jones [李琼斯]

