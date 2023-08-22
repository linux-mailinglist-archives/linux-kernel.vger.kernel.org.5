Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539F784384
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjHVOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjHVOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:10:30 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31CCFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:04 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MAnDcL007836;
        Tue, 22 Aug 2023 07:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pfptdkimsnps;
 bh=O01Fjm0nuNX4nF4tWJIpk4drtMKpsLoHfJL9kDZeqv4=;
 b=E9qKbgWevjvLQBq8YVGKjjkCX0luATRqyne+KQrjx3P8NpqSzDO374VjgjkaV3kAo8lB
 i6IS0LYcm94sAUCoOZITnorJF/pJzQkUl1Mzo9iTzzEsNM8sxhuox+sftx+A/klijB1F
 9BE5/YnfbRZ3mkIkoPwtwP489W9toMf6+uDcqbl+L2vHnXNbTmzRTPNgaOnnbClTNCfE
 UBQelhM4dOHv5/bnEtnfl4GtKbUm3OfstSt9bli8bfaLDcRETvb3RjS0K0XTWsK2N1Pf
 Abp0hH50Jq26NrTMocpadTzTLrYmnk9TNsIr6PEVQiBD2EYCubb/T4V4Eu98zbTJae2x WA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sjw05au5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 07:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692713321; bh=YYCuT1jfJo/0YPDBGcwDg/fGNFucp1OBH1HG1BdnSi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WV2n68PCsoaTkIGl+spOCLBRxqjKD8OeWWOdGHF0r7rKENciXIudicltuzIGaL0d2
         5ydQ/i/gF+V38+R8Jh+no3Id3Ffb0fFNYWlUJ/SFTga3SGvLS01RKppkqBG6LAQ/zB
         u7EcBFd87xTYcnDQMD05aqk5indRa4f0JXNvQ1ikcJjh9r08YqeFhRFyLIlapGKSs4
         yUgKFGdmYHKhTsHotVhrMLMOtOcnX9HES4aXyMaewVf6Q3EM7tCgiMtasDYYFolwwn
         l4UmAxHAtk4ZVIcHORNCngokuw5SVe4F8fxWGpl+ekmuZlj7RaxIqPSUzX9cxfstGw
         bu0DBgtgo+4Yw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 02D5F40352;
        Tue, 22 Aug 2023 14:08:39 +0000 (UTC)
Received: from SNPS-o0WHuHJU73.internal.synopsys.com (snps-o0whuhju73.internal.synopsys.com [10.116.105.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 9C296A007B;
        Tue, 22 Aug 2023 14:08:36 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Pavel Kozlov <Pavel.Kozlov@synopsys.com>
To:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Pavel Kozlov <Pavel.Kozlov@synopsys.com>
Subject: Re: [PATCH 00/20] ARC updates
Date:   Tue, 22 Aug 2023 18:07:25 +0400
Message-Id: <20230822140725.8383-1-kozlov@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rN4Z24ujRaGrQh-Knoq9EhoUbhWvimCL
X-Proofpoint-ORIG-GUID: rN4Z24ujRaGrQh-Knoq9EhoUbhWvimCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=529 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> This is a pile of miscll improvements/updates sitting in one of my local trees.
> Given the recent warning fix, we coudl also push them out.
> @Alexey, @Shahab: care to give these a spin on hsdk (and test ARC700 build/boot on nSIM if possible).
> 
> Thx,
> -Vineet

The entire "ARC updates" patch series (with all subsequent patches with updates)
has been tested on the HSDK borard for ARCv2 using the glibc and ksefltest test 
framworks and on nSIM for ARCompact using the uclibc tests. No regressions found.

Tested-by: Pavel Kozlov <Pavel.Kozlov@synopsys.com>

Regards,
Pavel
