Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B377C76B26E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjHAKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjHAKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:55:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB89444A5;
        Tue,  1 Aug 2023 03:51:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D37016607122;
        Tue,  1 Aug 2023 11:50:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690887012;
        bh=r8bUKLs/EE1Lr5TkhgdyZ8FacCjO5cv92z/FxABnHRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O1TA0pbiRUz6id7CDQeQ4Kb2EG1N0P3GJP2ZPoJbv18Um79Ubci5JFxMBnEeV876z
         6LK6FzlK5JwBTXdYdUIHUtuuApmLXVEFj2aYEazaWed3B5exMA6HvMQYCOLZ9CLJQ+
         VdbekA4xchcar+2QV75oqnUZcjBXsTx0X4irxY1E3Ztg1JCs9kVVyPNrBheTPeNiLz
         Cl0AsSWHkyexJ9GGcEoF+nLddVfI7hf3RQBn5tX+RwvYhIEnOkf405//Pz95fRT2WV
         mHg7VdOF/GmttfGoz4FMbRUdQNIPdymux2ACBVmCyDJ5qZeitPdhKpXFIB9wCLtBNV
         kPsLqCzGa+jsg==
Message-ID: <144125c0-4524-5617-dbb0-bf2575f56d4a@collabora.com>
Date:   Tue, 1 Aug 2023 12:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2] usb: common: usb-conn-gpio: Prevent bailing out if initial
 role is none
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1690869695-32018-1-git-send-email-quic_prashk@quicinc.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1690869695-32018-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/08/23 08:01, Prashanth K ha scritto:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, add a new flag initial_detection in the struct
> usb_conn_info, which prevents from bailing out during initial
> detection.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

MediaTek platforms:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

