Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EC7DE198
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjKANXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjKANX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:23:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D06CFD;
        Wed,  1 Nov 2023 06:23:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649F12F4;
        Wed,  1 Nov 2023 06:24:06 -0700 (PDT)
Received: from [10.57.1.80] (unknown [10.57.1.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079023F64C;
        Wed,  1 Nov 2023 06:23:22 -0700 (PDT)
Message-ID: <3d744ee6-a739-42b6-8a87-124746a9287c@arm.com>
Date:   Wed, 1 Nov 2023 13:23:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: etm4x: Fix width of CCITMIN field
Content-Language: en-GB
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org
Cc:     stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Pratik Patel <pratikp@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kaixu Xia <xiakaixu@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231101115206.70810-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231101115206.70810-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 11:52, James Clark wrote:
> CCITMIN is a 12 bit field and doesn't fit in a u8, so extend it to u16.
> This probably wasn't an issue previously because values higher than 255
> never occurred.
> 
> But since commit 0f55b43dedcd ("coresight: etm: Override TRCIDR3.CCITMIN
> on errata affected cpus"), a comparison with 256 was done to enable the
> errata, generating the following W=1 build error:
> 
>    coresight-etm4x-core.c:1188:24: error: result of comparison of
>    constant 256 with expression of type 'u8' (aka 'unsigned char') is
>    always false [-Werror,-Wtautological-constant-out-of-range-compare]
> 
>     if (drvdata->ccitmin == 256)
> 
> Cc: stable@vger.kernel.org
> Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, applied to coresight next :


Suzuki
