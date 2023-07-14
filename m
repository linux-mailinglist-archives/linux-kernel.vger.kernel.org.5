Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F554753125
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjGNFal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjGNFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB01CE;
        Thu, 13 Jul 2023 22:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A4A61BEC;
        Fri, 14 Jul 2023 05:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76670C433C7;
        Fri, 14 Jul 2023 05:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312638;
        bh=MrTOemuNAX14r32JWduG9a9ZjVgK0gkKejhuE4vOxV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnuwKDsJMy/HnQygJMmoEvrSlaNRUKJ9zudt9G+YXNu6vQGGjn+xqszdihWQfQnkX
         tAg8kklUgf3wYZ5/7dUQ+mWnW8c8PxOfGJbAWIbld92Cu9OZZOsb4DT/0QnjOyiBc2
         cwijOs6buqrVyD60uDzG1bhH/5871OG/dSIuOD2/eCmV4YElSodFmnStF+XxsBFla4
         JfRcgZ2uLwjyTjzISbbWat5gtXlIHOpl6kIiWPVoruW/GvoTfhOA38+/mPf2MR//Oa
         DR7mnX34M1zRBPLoYa4LqUlQ0dFMsejJAeY1ukMmjmvq71dsbedUOKyiBdyy8BUjQA
         evhE3L+WP1GFw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     keescook@chromium.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem: Use struct_size()
Date:   Thu, 13 Jul 2023 22:33:54 -0700
Message-ID: <168931284120.1538684.13992207018958031051.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <f74328551cfab0262ba353f37d047ac74bf616e1.1689194490.git.christophe.jaillet@wanadoo.fr>
References: <f74328551cfab0262ba353f37d047ac74bf616e1.1689194490.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2023 22:42:15 +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose.
> 
> 

Applied, thanks!

[1/1] soc: qcom: smem: Use struct_size()
      commit: cbdd13bfea785667f9c9df4c6ec46fc841ef6c4a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
