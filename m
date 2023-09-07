Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA49797A39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbjIGRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbjIGRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:33:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E841FD0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:33:20 -0700 (PDT)
Received: from [192.168.1.90] (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5383166072AC;
        Thu,  7 Sep 2023 18:27:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694107666;
        bh=MFE5K+P4IhknlSmSkjj7+xOGLPAgQT1claj8SyoDnFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GOKaypOV/j/n+/0toUVJ/SHi05O7Axsa/ErPuOJuml3iQIVLqxC3imWHX6u36G9RI
         fUio+fpPws58e4/yzuC/wAsBWrzmAwI4MSD9pLAePjvYLeihPf8eu6JUJYfprUruWM
         UKWzk2k6GTR5cW8ishITcNKzcXXZZOqxmX4nt/sUw++Blx9+lEiAfp54sAdQPMLKQH
         NuiDHId92y0rAL85mc6xH+cKzSLl4pUAr5jlhRRtFs59E0x4JwpguC/Z0awwo8n/7m
         tTOphWqf9hOBSvXovokeLDgrqNlyQM7xaY8ON05zFOe0MMUy6/9eVLkEK++dM+eY+i
         LZOu6eHEt4/IQ==
Message-ID: <2b7a8897-05dc-4856-bb1a-a38b1e41b447@collabora.com>
Date:   Thu, 7 Sep 2023 20:27:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Improve CS35l41-based audio codec drivers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
 <4a658238-b5cf-44fc-802b-f09f8d5e0ad1@sirena.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <4a658238-b5cf-44fc-802b-f09f8d5e0ad1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 20:21, Mark Brown wrote:
> On Thu, Sep 07, 2023 at 08:09:59PM +0300, Cristian Ciocaltea wrote:
> 
>>  - Added 3 new patches providing some HDA related fixes
> 
> Do these have any interaction with the rest of the series?

Yes, PATCH v2 04/11 changed the signature of cs35l41_global_enable()
function which is also used by HDA - this is how I noticed the
additional issues.
