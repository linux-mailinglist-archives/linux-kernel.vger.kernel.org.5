Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3D7AB98E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjIVSrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIVSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:47:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD107A9;
        Fri, 22 Sep 2023 11:47:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MIkSKe091507;
        Fri, 22 Sep 2023 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695408388;
        bh=cq21rBVdOpIQWHJQomoMydox8rjIZNV029jEU1u+BA0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RUtV8dMGc+ffZFwHwkBFZhGlhMRkErwJNIGn43Vsh5vEhoyGLsE+RQDySJ+ZGE4Zc
         nkrzG4sX3h3UtBpLUbwxOAfjeCb4MZK3E8QyjRvpDa/gQ1LcYGWj9i/VA8x2e5NVsS
         js44uEISyfKh7gULgQwAlwwAmZJhTGUwqjvlymtU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MIkSJB033965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 13:46:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 13:46:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 13:46:27 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MIkQJO022248;
        Fri, 22 Sep 2023 13:46:26 -0500
Message-ID: <7e43a7e0-f6af-94da-59db-377b790ca363@ti.com>
Date:   Fri, 22 Sep 2023 13:46:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 04/20] drm/imagination/uapi: Add PowerVR driver UAPI
Content-Language: en-US
To:     Adam Jackson <ajax@redhat.com>,
        Sarah Walker <sarah.walker@imgtec.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
        <hns@goldelico.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthew.brost@intel.com>, <corbet@lwn.net>,
        <luben.tuikov@amd.com>, <dakr@redhat.com>,
        <donald.robson@imgtec.com>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>, <mripard@kernel.org>,
        <matt.coster@imgtec.com>, <robh+dt@kernel.org>,
        <faith.ekstrand@collabora.com>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@collabora.com>, <tzimmermann@suse.de>,
        <christian.koenig@amd.com>
References: <20230906095542.3280699-1-sarah.walker@imgtec.com>
 <20230906095542.3280699-5-sarah.walker@imgtec.com>
 <CAD_bs+qdnVPYbmtzqcpCC8xdLVNvDb8uNccsd=P6YX+sgMG6Xg@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAD_bs+qdnVPYbmtzqcpCC8xdLVNvDb8uNccsd=P6YX+sgMG6Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 12:57 PM, Adam Jackson wrote:
> 
> On Wed, Sep 6, 2023 at 5:57 AM Sarah Walker <sarah.walker@imgtec.com <mailto:sarah.walker@imgtec.com>> wrote:
> 
> 
>     + *    :BYPASS_CACHE: There are very few situations where this flag is useful.

Could you also expand on what these few useful situations are?

Andrew

>     + *       By default, the device flushes its memory caches after every job.
> 
> 
> Presumably BYPASS_CACHE does something other than "after every job". Is that "never" or something else? Would be good if the comment was explicit.
> - ajax
