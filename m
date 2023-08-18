Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D93780AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376411AbjHRLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356757AbjHRLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:09:52 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E83590;
        Fri, 18 Aug 2023 04:09:50 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RRzff0T4Bz49Q76;
        Fri, 18 Aug 2023 14:09:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1692356986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnlFAxwLWBfzx3j9W8KMKISf6EkPs2txFDkcxVcdvrc=;
        b=FstD08SF6Iea03i6Edst5j6LG43BCjp5m/zC/8pWNqyFKA40HZlxEq8ff1hB3qsQ8BpJFB
        wZj0cerysVjPf0Ri5IBiVhFidHY0CRg0J6dTKKWzOYEcyRgdeMELEai556cfz0bjZyBeB3
        6Hi8E8loxPM0tfLwg+pZ/pk8ndQNh8LT1hSdrr9ITjuggNW95M3iOUaHAiyx22cWiuHvRP
        RUuAs/G6Hv1Rko/DV0MKRb9cn0BAmYDPQFgrFUQCfTPV2zVSB4WOi2f/f8KCnlh2q1W9kt
        TNoJbZ8TPx1xoY0CmtXo0kJr1EnP7b4ejUdRGL2HJuatGHc5RhWoQ9MRIj6FlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1692356986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnlFAxwLWBfzx3j9W8KMKISf6EkPs2txFDkcxVcdvrc=;
        b=DmXWNDw3CY1crqxD03y4DRXN6+BCGZOiYobqVqZbNcKth4HKUnuQiSZJBD/Kf4KUCtL45L
        YxllmZF2OudHhntOkNfqNsnG4i0M/NN2qmNqeWmquA+LEypLQfNwiIA1DDRPNh5pq1pqWy
        rYi3qM2dFzLj0VF/qkif7foXuG66qQbzrhQwwRchx88LTsNrWuOGo35GOtnSfIc96PH2Q0
        pWlntT7OJDIuDBSXKoyqvNdyOHOjtboyjdGUkMUcmzl0NKck1ZwKwZPzD5qPfZgaPnw9Qx
        +SCKeZ6v5QVJGIbpWuxp8TwdoeT5sgnQaVG8GQqYlSBZz0I1b+lP+0DitjYimw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1692356986; a=rsa-sha256;
        cv=none;
        b=lf3vsrriQJMQXmUjinPpSeEoN55fSdP94AC2sqgIU+misn/llgPKPCkr9rmqsOag0SwwDi
        S8zUQhoCxE2CySyFOOt7HN8q6kyH2Ckoe0e4988OPhiHufI9rbSGDvrib0YPe7NLhk0fFk
        KSq1LfBVS6d4t3zl4m813ubCVj46WXnzox8zbfh5LzAeAJmnwCQuErf/z3/vBsCG7qulC3
        Ao2GDGp4drmxidQOomJknHEHvRGsHaT0Vbm3KBXO5pzAg1by4M5ekKoy4Cca0TOfFiKbyy
        6/IJh2GN5VGfECXu340Tf7vRVrinCEDEIAc4Z50F/KwyATkf54Y7AQS4TJRFdA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 05E1F634C93;
        Fri, 18 Aug 2023 14:09:44 +0300 (EEST)
Date:   Fri, 18 Aug 2023 11:09:44 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        hverkuil@xs4all.nl, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: v4l: usb: Use correct dependency for
 camera sensor drivers
Message-ID: <ZN9ReILfgRbIAolx@valkosipuli.retiisi.eu>
References: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818095149.3863285-1-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:51:49PM +0300, Sakari Ailus wrote:
> The Kconfig option that enables compiling camera sensor drivers is
> VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
> Fix this.

Due to marvell changes it should be added:

Also select VIDEO_OV7670 for marvell platform drivers only if
MEDIA_SUBDRV_AUTOSELECT and VIDEO_CAMERA_SENSOR are enabled.

"usb: " should thus also be dropped from subject.

-- 
Sakari Ailus
