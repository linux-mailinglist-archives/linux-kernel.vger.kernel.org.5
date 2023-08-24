Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7857787835
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjHXSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbjHXSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADEE50;
        Thu, 24 Aug 2023 11:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FD963A36;
        Thu, 24 Aug 2023 18:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240E7C433C7;
        Thu, 24 Aug 2023 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692902749;
        bh=5Mb0MpT4Rr86M02kOZb7MIamOKaM0JtZAhyMccOWT7s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nI4Lgs8EfxsSd5q6uLEntRdh9HoZ9PQxpfpgVjEhcdxgcMyPdyCeoXzbSPgM0YUba
         V93MQQK8jnVd2TUM86y7SiVCNab/5bLyXG1rlHB3h786/LQu33QaadrO1tOjHOk+Ju
         mBs08j8J3U2Gk1Jdh1o+1nhT2w8sryXzcnJwOmVlVcH+cFJPM5pWr/D+uz8NteZA+t
         lvTRgEOIM/nOXxcpyyWCJqKl0MUcJLRdfCfkg+gFiF/fLbHJioCvEolH0nPllmuZgx
         BbtfXmj0qDFObi4IFjRLxgyUyAEM8qro1Q1n5gjdjpucvI3trHm+yj4ZIexq2fwuiD
         vA2NItjLkKZvg==
Message-ID: <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
Date:   Thu, 24 Aug 2023 20:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <20230823124340.GA2022486-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230823124340.GA2022486-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 14:43, Rob Herring wrote:
>> +                                                          |
>> +  +------------------------------------------------------ |
>> +                     |             |           |          |
>> +  userspace     /dev/ele_muXch0    |           |          |
>> +                           /dev/ele_muXch1     |          |
>> +                                         /dev/ele_muXchY  |
>> +                                                          |
>> +
>> +  When a user sends a command to the firmware, it registers its device_ctx
>> +  as waiter of a response from firmware.
>> +
>> +  A user can be registered as receiver of command from the ELE.
>> +  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
>> +  the id of the driver and Y for each users. It allows to send and receive
>> +  messages to the NXP EdgeLock Enclave IP firmware on NXP SoC, where current
>> +  possible value, i.e., supported SoC(s) are imx8ulp, imx93.
> 
> Looks like a bunch of Linux details which don't belong in the binding.
> 
> Why do you need your own custom interface to userspace? No one else has 
> a similar feature in their platforms? Something like virtio or rpmsg 
> doesn't work?

+Cc Greg,

I doubt they care. This is some stub-driver to pass messages from
user-space to the firmware. The interface is undocumented, without
examples and no user-space user.

Best regards,
Krzysztof

