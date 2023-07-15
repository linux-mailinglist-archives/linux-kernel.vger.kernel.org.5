Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FBC754BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGOTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGOTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61D5E5C;
        Sat, 15 Jul 2023 12:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7253F60C44;
        Sat, 15 Jul 2023 19:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B5C433C8;
        Sat, 15 Jul 2023 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689450134;
        bh=7sf7vGd0tZtQYpjA5fPSV3OxDzoB/Ea9h6a4YuDAJHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR6jcH6W/0aMYk8iPEDvYbhubknkPJQlLGFWHpkChgcx8Ox22vS8TBL5486ncNwkE
         QCt1jWRr3O52U85rcZtKfwfyRZ0oZuy9Ijc+U6ByBQRn/zh24X6f73a7oEdIdgORvn
         fHKoIE4/Ff5T602sqkr9fREm7gKMXowp3MwrrST5EOkgetVS5zMhBFQ7tdWQIOVSk+
         YGACFRXm19jsVnFFkhxhvYbaRYa9HCvOAFPfwZhhF9joED2a6qEEyLhWezCjdsHX4/
         uTm6Fp0UatEJ+OrOpzI7ynFD/0v29N3OfCjoMhqUjwEf1tXkblsOiusErk9FGq5UEr
         o7bMYVC/Cf6aQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v3] remoteproc: qcom: Use of_reserved_mem_lookup()
Date:   Sat, 15 Jul 2023 12:45:37 -0700
Message-ID: <168945033424.1736171.17829824538701917090.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710-rproc-of-rmem-v3-1-eea7f0a33590@gerhold.net>
References: <20230710-rproc-of-rmem-v3-1-eea7f0a33590@gerhold.net>
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


On Mon, 10 Jul 2023 22:34:52 +0200, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: Use of_reserved_mem_lookup()
      commit: 0ee55c188a3c97309a6794077d5ef4ebd58f62cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
