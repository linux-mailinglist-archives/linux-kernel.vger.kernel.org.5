Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2157CB6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJPW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJPW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:56:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FA6DB4;
        Mon, 16 Oct 2023 15:56:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB6A1FB;
        Mon, 16 Oct 2023 15:56:43 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 732AB3F64C;
        Mon, 16 Oct 2023 15:56:00 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, andersson@kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        devicetree@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Hao Zhang <quic_hazha@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/13] Add support to configure TPDM DSB subunit
Date:   Mon, 16 Oct 2023 23:55:36 +0100
Message-Id: <169749645670.708996.15857660455300716128.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
References: <1695882586-10306-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 14:29:33 +0800, Tao Zhang wrote:
> Introduction of TPDM DSB subunit
> DSB subunit is responsible for creating a dataset element, and is also
> optionally responsible for packing it to fit multiple elements on a
> single ATB transfer if possible in the configuration. The TPDM Core
> Datapath requests timestamps be stored by the TPDA and then delivering
> ATB sized data (depending on ATB width and element size, this could
> be smaller or larger than a dataset element) to the ATB Mast FSM.
> 
> [...]

Applied, thanks!

[01/13] coresight-tpdm: Remove the unnecessary lock
        https://git.kernel.org/coresight/c/5d49aeb1b3e4
[02/13] dt-bindings: arm: Add support for DSB element size
        https://git.kernel.org/coresight/c/a1ce72d22a2e
[03/13] coresight-tpdm: Introduce TPDM subtype to TPDM driver
        https://git.kernel.org/coresight/c/6b4fad1b665a
[04/13] coresight-tpda: Add DSB dataset support
        https://git.kernel.org/coresight/c/18e176f77986
[05/13] coresight-tpdm: Initialize DSB subunit configuration
        https://git.kernel.org/coresight/c/03f0ff5fcbec
[06/13] coresight-tpdm: Add reset node to TPDM node
        https://git.kernel.org/coresight/c/126f00822388
[07/13] coresight-tpdm: Add nodes to set trigger timestamp and type
        https://git.kernel.org/coresight/c/c821b93bb6eb
[08/13] coresight-tpdm: Add node to set dsb programming mode
        https://git.kernel.org/coresight/c/535d80d3c10f
[09/13] coresight-tpdm: Add nodes for dsb edge control
        https://git.kernel.org/coresight/c/dd60b994b3f8
[10/13] coresight-tpdm: Add nodes to configure pattern match output
        https://git.kernel.org/coresight/c/5898244cf458
[11/13] coresight-tpdm: Add nodes for timestamp request
        https://git.kernel.org/coresight/c/949a4f5b66d2
[12/13] dt-bindings: arm: Add support for DSB MSR register
        https://git.kernel.org/coresight/c/20dab0f44ac8
[13/13] coresight-tpdm: Add nodes for dsb msr support
        https://git.kernel.org/coresight/c/90a7371cb08d

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
