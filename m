Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80976A7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHAEep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAEem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:34:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39919AA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690864460; x=1691469260; i=efault@gmx.de;
 bh=PQ8MYzj7tx0D6eyvzO9rkGF0u0ZBtZ1Vj9Zolp3Zmx0=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=YbRUkFlYSVkvCC9TeMj+MwFmupcB/MFDA9zQN46l5LO8ICf3jNyeodX7Xo8JDJS2c1Upc/5
 SqdhcWof1uIM4L3S0aNgAI1hasjD7sjoJfjFUK+eNDgfNvrtgwizpVqCjfub/FUbb1rMD+6Ss
 0jkE7A5dZGrI1F/L02pjUTv2vdpfoMVcbVjyLSjPw0DvSvCD0lEegZveKbjXMw1hSJ0k/DUCC
 LnUovKQy6OGwy5rAqPiKLz6BqlZfmzz0FgLdLPbeSY3k/IXYdWlfKPa3Pi0Z+PibCw9zryZqR
 /79UZVsWK9nepAMAPmcXSwzhgi+snFt22p5bG25G0dMVkoGxUGvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1qZWn53Sz2-008pJl; Tue, 01
 Aug 2023 06:34:19 +0200
Message-ID: <7b94619ad89c9e308c7aedef2cacfa10b8666e69.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Tue, 01 Aug 2023 06:34:15 +0200
In-Reply-To: <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
         <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
         <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
         <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
         <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WF3o3Z0bH2Jh5FJFVwqfBurryUQqVFhkgFUlgp+VVvU+OVw0AGw
 QAz0GFvzDjTkZQB8FaLgyXtvzRytLzU7XnREyEStVVyylPaD6/03bJTo9QpxGs7bfG1SwpG
 E9gDpFRF54ylKwBgdpBuPTM4enkVRVv03+aUmdsyabgWWrw28zO6TG2GdLTyOx6vM/58IAT
 8Wgk/VkKaRaP6UtRl3w3Q==
UI-OutboundReport: notjunk:1;M01:P0:oLZsSaxHviY=;4N930vPxC4j4xtc5eq3Gv50vNdp
 gzgf00bVdOURdq2BJydI9Y7XtyR+rEGKwA48rFTXFvkyalyLWVhi7XioDdlgJZmJckb02wWd1
 ias8jRGMyAo5TyqD5vsjoRcnv9g8LIseWBdTyAaqDAPOCCLufMkxPNl6oCiT0DCQLn6qM4pSC
 TA9hqF6y6mgg8TK63QoNfAvxG3bI8a/f2oc5sSGn4QJN3jAWFALhGCPnE3AeapSP3SuPQnQuB
 CIACf8ZNOXIE4WEkvFbWMXqLXASRcm5ZLmVzF/yK+ysOzDfvvPAOvCqRdxWvxAN8b1lNrZJlV
 aGDhbNblZdCtAw+fUSSBlMSyg2WQw9VNoYopUcOVRK2pLzQH58LB4Wm2/P7qv0HolbIjxaeAR
 X6Fb9EcA7BLzxdHshVl0EeUNsN2zQcou1Q603P0lptxGGqXkhNKDPVCoOJ3txDnBal/LvHQ/W
 lP7rAnODNAHxKk5ndV4MwFO28+LcUOmh+mXJcQZ7FgDMefBBw6KXJ7daqcCStcG9HkN3ps7h8
 QjVplKKqBJ/DAZ/rJXVv+ScM4S3fJrQSWn0r5gTYZAK6dZTClLJTsqW04YCJMfUmTc3EKXQUP
 25omxqPZFGvzCGQXL8JjzjRPDgQAiAKv1ajBFwxVgRzneQ1p6Plo805m4AiA9R05XZpUSZExq
 hp3Qdb4SXkgmjA4Lg1qJrI/Wz86BIYe4wsJN2HaSwKmD1apf/42v9aH+gGdfwYhyRZUbIs7oj
 hziXgMhmXLlVX3WkVGvuDLx9E/4Qt4io5uYSjiotyIEo43f7uRt5d7wF+ooBCrkb0u0nZYpwg
 lQ+7AOave/L70w2IaY7dN9XNivEHAYK3eslbSEeycBiWoqB07caOGm8whCkqwoLDyB9ZKocQP
 VySoJa03iXV9QNVAgNXIIYKUgSFmnF5kryb4r7eZDGaBIpUa2tbh2l3Xxhd2xoUFDd3vF/KhL
 4fg6V+Lv2vJhpQldUO5Y1KIhwbA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 01:48 +0200, Mike Galbraith wrote:
>
> root@rpi4:~# dmesg|tail -2
> [=C2=A0 979.003019] __vm_enough_memory: pid: 12439, comm: objdump, not e=
nough memory for the allocation
> [=C2=A0 979.003080] __vm_enough_memory: pid: 12439, comm: objdump, not e=
nough memory for the allocation

Ancient bug droppings are due to VMALLOC_END-VMALLOC_START=3D265885319168.

	-Mike
