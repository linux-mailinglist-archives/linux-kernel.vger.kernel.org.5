Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31967B4048
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjI3Mpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjI3Mpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:45:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB71113;
        Sat, 30 Sep 2023 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696077949; x=1727613949;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GG6PAvdaQK/bu6ZQBHskaNL8ui7EImmxk/pB8UsT5F8=;
  b=GkCC64y/aCO2HN7eIGePVUAKVpwolpuAHbDsBw4RGGDndNpfVLX15oSo
   jrVv/tcN2VXjhIes4SWL527H0NuwQBr2VJKjuuX1phlfctwWQNPpeTry3
   wrvA4D1FpYsw6JvztBXVLhC45xk8IDnQVAtTVdGS8809TfVD+8t5sRjoQ
   HfhRI1FwTAt52ayLdsjhxAxk7W1kiSF1VLQO6FHpNVehym4o4gQCisxcM
   OHS2xxizaoAv5GwEuUIsI4hbX2/D8SGpW8GmEpwIGBC2LN2EJmUJEQapf
   hWcTYYZJvknCr6sGHN10QfmzXEcLX1QWBkdPlv3InfwULPff2qJY7HHme
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="448934353"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="448934353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="785347605"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="785347605"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:45:48 -0700
Message-ID: <0b5ec7bdcc8fcaaf9b75c70c9599233f1934fd54.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 30 Sep 2023 05:45:48 -0700
In-Reply-To: <9d9d1c7e-482b-8817-a09b-9ce364a74cf@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
         <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>
         <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
         <9d9d1c7e-482b-8817-a09b-9ce364a74cf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 17:33 +0300, Ilpo J=C3=A4rvinen wrote:
> Also the shortlog could be improved, IMO. E.g., Ignore minor version=20
> mismatch.
>=20
This is not just ignoring minor version, important is error on major
version change. Instead I can change to
"Process major and minor version"
or
"Check major and minor version"
