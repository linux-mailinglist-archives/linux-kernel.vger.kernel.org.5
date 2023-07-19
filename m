Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E47590AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGSIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGSIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4D1735;
        Wed, 19 Jul 2023 01:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C453B6133D;
        Wed, 19 Jul 2023 08:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A93C433C8;
        Wed, 19 Jul 2023 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689756789;
        bh=0Yredh4LIP8grtMgsepVBspLoZr9YmIEt/7cMB2LDSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMfRqdRIkkQR+2Am8sMRg09bfwsVxuoqrBeZc6ytOQz7DLpcSwJtMyqUTxS8xXAJG
         dd45Qtfg7yg5xqfsWuuGE+uUqNMQdBk9heoitrUv9IW/caZMY5L7vIh1dMqnrn93db
         sWIyRmSGpQitVqVPQZBQhKtEYp/IP2W45BCQAlRZ8chaZlSna2sFI/xwGUV0k+EYZP
         gdOsxBwzAVt+SOVADhdtaV7bHuWC8MKcNnh9ehxJlZrctcawd2mnsPMysmbyycZTKa
         MFOyAwhXC/y0oUOuDeNDhzcy31OKiEU886vDpwiKdQiwlnPdcKOPzLEoL0qyqTKn/d
         3An4mCYMDWl5A==
Date:   Wed, 19 Jul 2023 09:53:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on
 &chip->pm_irq_lock
Message-ID: <20230719085304.GJ1082701@google.com>
References: <20230628072840.28587-1-dg573847474@gmail.com>
 <20230713101848.GM10768@google.com>
 <CAAo+4rW8hK9WZzfXQ3wLf1i_xKMksXM1sffbmk6+kyJ8kVtfGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rW8hK9WZzfXQ3wLf1i_xKMksXM1sffbmk6+kyJ8kVtfGA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Chengfeng Ye wrote:

> > This is very old code that you're changing and some of the people who
> > made the largest contributions are not on Cc.
> 
> Thanks for letting know. Will be patient while the patch is being reviewed.

No, I need you to resubmit it with more historical people on Cc please.

`git log --full-diff` should help you trace back through name changes.

-- 
Lee Jones [李琼斯]
