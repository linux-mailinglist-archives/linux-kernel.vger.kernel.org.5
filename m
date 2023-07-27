Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D3764D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjG0Ifc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjG0IfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:35:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9486195;
        Thu, 27 Jul 2023 01:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D6961D91;
        Thu, 27 Jul 2023 08:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE550C433C8;
        Thu, 27 Jul 2023 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690445890;
        bh=f23MYfOTjtmXZu5cjF+AYtaCTsegaO8tfeUfGNU27g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0X74+uHNUnKOZ6Gbbo8+PbWMLNdb35arh/4yxQ9hKLzQXNV+2xv73GViJ4XtuYstL
         AV43yNpTvaZA2CjgBTh26/HtT7DstPVVqnX1lnksab26k/Bhp7VdzzVWMe+WMslxHv
         yLrQOX3yoJRrJ+ImO1gRVOEEIglqjJ2xtzVcs9Y4=
Date:   Thu, 27 Jul 2023 10:18:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Surong Pang <surong.pang@unisoc.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson.Zhai@unisoc.com,
        Zhiyong.liu@unisoc.com, Surong.Pang@gmail.com
Subject: Re: [PATCH] usb: dwc3: gadget: let pm runtime get/put paired
Message-ID: <2023072757-struggle-quirk-2c4b@gregkh>
References: <20230727005150.18836-1-surong.pang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727005150.18836-1-surong.pang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:51:50AM +0800, Surong Pang wrote:
> ________________________________
>  This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
> 本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。

Now deleted.
