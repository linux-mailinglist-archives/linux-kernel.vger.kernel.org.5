Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1808D7B54F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjJBOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjJBOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:24:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F50BD;
        Mon,  2 Oct 2023 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696256684; x=1727792684;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g52ObCzsdEtP+9TPeRFfbxkm0gDt2NIsamPGsnMX8Zg=;
  b=DejbS63rf8oc4FiCMmBHJCeUmv7v4d1aYH1V6ludr7vzQcxSrl39k2fJ
   0OcEHkpbEJBH7BQnFdB08mhza1vDonIUPsnTHBHV9j2IvfxLDcoB+IQpx
   NMPZj3vM1YnfpnK2CwUaX4w7fAv8mrHJkvDdXu5cgXbeHSjhCq9v4i/rp
   GdW/NF66xUqNaJaPChNzz2Aex/O0Bvap65UrjB6sQRGjJ+jrbtoOkXqgo
   qxfuOrsJ6Yf0CXBnxd8LJlwuNFOeW7Soyh6CqF3FbsEBDtvf1YvWNB7Rx
   xu9qPQhnag6HSI43Pon4xvJhampTm/V+bvri+XgOWa8ny8SbUv1Tl6RDt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="468931135"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="468931135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841002773"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841002773"
Received: from roliveir-mobl1.ger.corp.intel.com ([10.251.222.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:24:13 -0700
Date:   Mon, 2 Oct 2023 17:24:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
In-Reply-To: <daa44585c4a57b8823cb260d9ec9bd3f59f410c6.camel@linux.intel.com>
Message-ID: <4098d4a2-f672-3c72-5ddd-b397e2ed1465@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>  <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>  <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>  <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
  <45625e9e-997b-eba1-413a-43a7d835feb@linux.intel.com> <daa44585c4a57b8823cb260d9ec9bd3f59f410c6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1525224698-1696256654=:2459"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1525224698-1696256654=:2459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 2 Oct 2023, srinivas pandruvada wrote:

> On Mon, 2023-10-02 at 16:49 +0300, Ilpo Järvinen wrote:
> > On Sat, 30 Sep 2023, srinivas pandruvada wrote:
> > 
> > > On Fri, 2023-09-29 at 17:28 +0300, Ilpo Järvinen wrote:
> > > > On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
> > > > 
> > > > > Parse major and minor version number from the version field. If
> > > > > there
> > > > > is a mismatch for major version, exit from further processing
> > > > > for
> > > > > that
> > > > > domain.
> > > > > 
> > > > > If there is mismatch in minor version, driver continue to
> > > > > process
> > > > > with
> > > > > an error message.
> > > > 
> > > > This sentence sounds odd.
> > > What is the suggestion here?
> > 
> > These things sound wrong: It should be "continues"
> OK
> 
> >  but I also find "to 
> > process" odd when lacking what it processes.
> 
> Further processing means, whatever this driver is supposed to do. You
> don't want to fully explain again what this driver is doing.

Well, whatever. I'm not a native anyway so I cannot really be the defining 
authority how the language gets used so feel free to leave "to process" 
as is.

-- 
 i.

--8323329-1525224698-1696256654=:2459--
