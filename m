Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435DA7B2FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjI2KVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjI2KVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:21:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E70C0;
        Fri, 29 Sep 2023 03:21:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EEEC433C7;
        Fri, 29 Sep 2023 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695982899;
        bh=+2zBsjqoJzmRSTJwJguyALkmIBOSjgetCm1y/CgYy2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSOII6snpINNn77ls7lb3TKnyCuss9CPxUksQDwwLC2CWsC+jXCCj5TSvnboufiB8
         FTtzT1w9gMkzpALX/7zWFNv3K8TdrSRtAt75vUypLImqWCuihAAmtUqjN5EiTU1CPQ
         3MdsQFbxFTL/V4KIOKdtN6VzogxizI7UZkS9ZtoyM7XKpP8cDujFBKmGmQT7k2hFGe
         A04ShedLOZKppDuqZ9NKoQa0sgcO9h0tqTC+8Ub+28/Ymx6qpdJstDoSr8z//3nuO7
         5lzR/0/t+wRhuKBUzte7b7qEMOt6riUeVFkffuQ0Sq2xW2cM71vjZhhZRsHhKUsbav
         N/08e6O5aDdHw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qmAcs-0005HB-0S;
        Fri, 29 Sep 2023 12:21:38 +0200
Date:   Fri, 29 Sep 2023 12:21:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix battery_id type
Message-ID: <ZRalMiem9dcDiYHm@hovoldconsulting.com>
References: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
 <ZRahE9StzjDMzaCy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRahE9StzjDMzaCy@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:04:04PM +0200, Johan Hovold wrote:
> On Tue, Sep 19, 2023 at 02:42:22PM +0200, Sebastian Reichel wrote:
> > qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
> > and should be of type __le32, just like all other 32bit integer requests
> > for qcom_battmgr.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@intel.com/
> > Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")

I think you should add

Cc: stable@vger.kernel.org      # 6.3

when applying as the robots may run sparse on the stable trees as well.

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
