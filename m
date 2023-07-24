Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1375FA09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGXOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGXOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000E1AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55130611B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A1FC433C7;
        Mon, 24 Jul 2023 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690209601;
        bh=fFklD/dD3ZlIrQ8Dme3nM4aHtIVER8kIWVHDgtLowiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YXK56mglYQbhe0yCW4Y17XI9jEHo5EGCcO0SEyxZRYKyEJreND6e4eM+w0OTTeQNR
         4dfDsaR6BTkFpyim85b6y8cQp9x0Hnjw7WDI0c8PNN6cz/BrAYtxz4tTJ0qiJqmYte
         zFNODQJpsaJyS6AAljj+3NdjLW4imvnaTv2wQcRkVMe5gd139BOaYp9sdIQH4d+5ak
         8s14NAAYfBJPULbW9m0wevkrTg9I+yecCSQMP+bjmmdRfImelasIwfUMR0oMpeL+OD
         ALHB0y2Ktz2D+d/Sm/VbRdqtAS6idQWaOEA7Ol2G2e9viEsrJXnO7L5whFoiXv4pwv
         igX1Iqi89/lIQ==
Message-ID: <4faac72e-3ab8-6a07-dad0-7be8840da7c4@kernel.org>
Date:   Mon, 24 Jul 2023 09:39:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] firmware: stratix10-rsu: query spt addresses
Content-Language: en-US
To:     "Lee, Kah Jing" <kah.jing.lee@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bacrau, Radu" <radu.bacrau@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>
References: <cover.1689524302.git.kah.jing.lee@intel.com>
 <e640da0517b1d0de79013fdf4964ea34475f2238.1689524302.git.kah.jing.lee@intel.com>
 <PH0PR11MB56738D1373C7B2FEA7D947A9CB3FA@PH0PR11MB5673.namprd11.prod.outlook.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <PH0PR11MB56738D1373C7B2FEA7D947A9CB3FA@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/23 21:34, Lee, Kah Jing wrote:
> Hi Dinh,
> 
> Any feedback on this patch ?
> 

Please fix these checkpatch warnings:

CHECK: Alignment should match open parenthesis
#64: FILE: drivers/firmware/stratix10-rsu.c:275:
+static void rsu_get_spt_callback(struct stratix10_svc_client *client,
+                                    struct stratix10_svc_cb_data *data)

CHECK: Unnecessary parentheses around 'data->status != BIT(SVC_STATUS_OK)'
#70: FILE: drivers/firmware/stratix10-rsu.c:281:
+       if ((data->status != BIT(SVC_STATUS_OK)) || (*mbox_err) ||
+           (*resp_len != RSU_GET_SPT_RESP_LEN))

CHECK: Alignment should match open parenthesis
#116: FILE: drivers/firmware/stratix10-rsu.c:626:
+static ssize_t spt0_address_show(struct device *dev,
+                                 struct device_attribute *attr, char *buf)

CHECK: Alignment should match open parenthesis
#130: FILE: drivers/firmware/stratix10-rsu.c:640:
+static ssize_t spt1_address_show(struct device *dev,
+                                 struct device_attribute *attr, char *buf)

CHECK: Alignment should match open parenthesis
#190: FILE: drivers/firmware/stratix10-rsu.c:787:
+               ret = rsu_send_msg(priv, COMMAND_MBOX_SEND_CMD,
+                               RSU_GET_SPT_CMD, rsu_get_spt_callback);

