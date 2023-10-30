Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3A7DC01B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ3S4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJ3S4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:56:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FCC9F;
        Mon, 30 Oct 2023 11:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DF8C433C8;
        Mon, 30 Oct 2023 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698692167;
        bh=zfAcRGpM6KrH3AASAFPkdWrwC4DVnNmCXJNxrZXU+x0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fxBA+dbOQxuP4L+BMvnmXPTQcSgUWuS0VPsZeFLa6lRXGhEnDY2ECTvgabWgp4HaH
         wDDrwR4Uqlvwj+PHd1pFg9Bl35vYVIErmIHvIT19ZwzuxYJPLMRFVcKbpDlX1YgSne
         H6t9upXRPoQOBmSVn5Udd7S/Y/zt+L2UvoOuLGCUaPHQbHkcsAc2NScsUZTshjnRLH
         XZJKFy7WNgpBRu+v+vzgOhZRHvhbvFCBAIs+Ql+r54Oe7hqwTsHxAbnPVv1+ElslSj
         zoJJqBLgQsxGV46N/o5xYf3oh0hMB0C1zHK1SAq1BRaSdstHe64rwdqY0l0yipYKlN
         nwNc4RI1XJRlw==
Message-ID: <4ac6b9d1e6dc7859b39fa456cec70fc7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com> <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
Subject: Re: [PATCH 2/8] dt-bindings: clock: ipq5332: drop the few nss clocks definition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Date:   Mon, 30 Oct 2023 11:56:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:17)
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> enabled by default and it's RCG is properly configured by bootloader.
>=20
> Some of the NSS clocks needs these clocks to be enabled. To avoid
> these clocks being disabled by clock framework, drop these entries.
>=20
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---

Instead of this patch just drop the clks from the table and enable the
clks during probe with register writes.
