Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2D797741
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjIGQYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbjIGQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7625590;
        Thu,  7 Sep 2023 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694103625; x=1725639625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zNEMailIgyjBosQEtquAMy2L53kNHUSvhKExjYy6P7A=;
  b=JSCaa2Tyf5AQDS30GUQJlOP3DapuBjrnOKgjAb/4VmgR1sysDI+nnN0g
   mX8kQAz4I99gUWgMKH3BZrCVrSozvuS8tnZUmJjyrsm9L6u3OvOJyoZZg
   FxUBstM4p/1HuffqRCc7bhlQPELf84osP/YtpUGxqtb3f93d3pRmxvbv3
   UUJXpJnsGBiBX5RNPAWV0aqsUWHnJYFkfi3TQt+O/6k/2IKTnd9pwplib
   QMSpkfGb73x4Defg6V3my9N+zvjEC+6tV4t3dC1tiOrAk9YhvbInl8Cq0
   HPY6MZzaOM4qBePeWTnaVaGXpsWBaVUd0Ju2lVj8LlOaDSc8Zn/UTA0dy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441325204"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="441325204"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072875259"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="1072875259"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2023 05:24:24 -0700
Message-ID: <ab235faf-1640-e231-bead-1301eebafc92@linux.intel.com>
Date:   Thu, 7 Sep 2023 15:25:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v11 03/13] usb: xhci: Move extcaps related macros to
 respective header file
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-4-quic_kriskura@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230828133033.11988-4-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.8.2023 16.30, Krishna Kurapati wrote:
> DWC3 driver needs access to XHCI Extended Capabilities registers to
> read number of usb2 ports and usb3 ports present on multiport controller.
> Since the extcaps header is sufficient to parse this info, move port_count
> related macros and structure from xhci.h to xhci-ext-caps.h.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

