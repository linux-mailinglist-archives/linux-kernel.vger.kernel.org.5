Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826EB778473
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjHKABt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:01:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349492D55;
        Thu, 10 Aug 2023 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691712106; x=1723248106;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P70HWqR6SWRT2ByEsRd0edh1MoygeylirGv6RDishuY=;
  b=RjCy/l7fyvlL9+uoXx7nSXwslhsd1UUFSPLTrzzNpyq0W7hSE4Vivcns
   PO8pVQePi8Op00ErzD0zeN3ZaiohtV4Vo7SPfJtk21Dh8QPOt8dzWtmmb
   Z+FBXJYW2/d1QPUk8HOe90c6XQanC03TlP05Dfy0bOY495ZH7Nh+AANbs
   kjUGPEAenAhYebgQSk22wYM06J/MUjollVJf3UKC7rfrN7loXMateCmsB
   FDvkNVQhZB4e09UIQS2peyM/AE3sI9GrbHrVKPjL6D1RhISKwwTIVmM6T
   PkDLKZLV9Csni93BkKxLHuRkr/2aqcvWttb1XQ4T3W0GX6wvflzWXlZmp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375267643"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="375267643"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735594491"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="735594491"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.102.89])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 17:00:03 -0700
Message-ID: <c57f5467749111ccaedc3e125d6f9db50bca70c1.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/7] thermal: intel: intel_soc_dts_iosf: Cleanups,
 fixes and usage of generic trips
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu, 10 Aug 2023 17:00:03 -0700
In-Reply-To: <5713357.DvuYhMxLoT@kreacher>
References: <5713357.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-10 at 21:08 +0200, Rafael J. Wysocki wrote:
> Hi Folks,
>=20
> This series is on top of the cleanups one posted yesterday:
>=20
> https://lore.kernel.org/linux-pm/12271935.O9o76ZdvQC@kreacher/
>=20
> It continues cleaning up the driver, fixes some potential issues
> related to the ordering of actions in it and finally makes it use
> thermal_zone_device_register_with_trips() for the registration of
> thermal zones.
>=20
> Please refer to the individual patch changelogs for details.
>=20
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Thanks!
>=20
>=20
>=20


