Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38367EF395
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjKQNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:16:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B370D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700226962; x=1700831762; i=deller@gmx.de;
        bh=d41I09Of2YlpgB5uKQmlEG1iefIIC8G5swjr11flPyo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=GJk4W7B/O63ROlPHsvyZOSwZhK54Vnq8sHJrbntTrRfPeHa2nJ7usEdEN+htuPqX
         x2PCTNO04TIdWkNNcoQskLqYQwaejTKMoEWoqOSyLVr6uGYCBMRNt1muxFOp1iAVd
         0Erz1AbBjjLp6Hu+A22rBy3dNJsBN52W7c84eDys2wIUL1h9oBeuYv1yZqjncS93y
         eif23/doi8HDInR0o1sPokjwbNN2ME3piFHN91GuhWwLeMTbKhP4sVZLCFHwtF8+3
         jNp2JA/KGxSIv4ToDn9VgYpTr5b1SO9KU4PJPabbIf3++ivsMqbvwQbyMK4O4EQPQ
         LOI5RGSk3e/ZEP1glg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.146]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1qhNND3qRG-00MY58; Fri, 17
 Nov 2023 14:16:01 +0100
Message-ID: <a13df827-cd2c-481f-87ed-719936b96c41@gmx.de>
Date:   Fri, 17 Nov 2023 14:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: missing
 identifier in declaration
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202311172127.5PEz8XzL-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <202311172127.5PEz8XzL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2MP6qMlCT/3DOVaYbo8+pNmyqfSBpXdNqAW4coAnpeI5F2VA8Pw
 +f6/xLpivG46BLMnilf5MPmFUgCCbHYWZoNAuierL1QsHYD9TaSf2//EMs9byWAcdJeIuV6
 4E6jpv8ZzFBADu9ciXSHI4m3Uq4u8xV7hHNff9gy3MCjBxmoAN8haJAssF64NF4m8X6AFeH
 9PcpQvnS64bmyLrh5LOHQ==
UI-OutboundReport: notjunk:1;M01:P0:O3WHSLZvOek=;tR9F4A/2IlCFkWUzqGuRl+tEWCX
 In71UCJTwCeeyLuW7yWIMc9Px/0TvNUSClHcVv+yeo5FRl3wtP9wUPHYGG8jIjem63mYlwAZ0
 yPhWtuD7IiMPJG7uoy5d4Ryo8A9hIhrWZrDuOO8993ajI32nKGKNoIGfmlomvF5rA858l8OFD
 bm35VE0ajKAUdLCiwpfZuOno80Rud4KF4UCzidaPbnLbOQiO3kNmuzylr6KwOnmZXrszNt+Nw
 Z2o+N40DrmD3LcKW1C7HeJvwvcwbc7FKI32XHBVwrBugONF2ba2Cr8Qp0H6f/mmJQjti8SHkJ
 PEtJtfDqPkCxWo7F1YI96GwZENO4Nrn6O+1UiMK44VTj64penSiW0a/Ci5OT/TWHr18SBUR+W
 E5mRbGcJ6fg5KDbGa0DPTX6UNG5elIOYFsAAZFg3Yvo9Omdz1SECSQWisGy+1JcXMvfbIrtif
 wck/P5XTQYS/VayJLf5pyPK7zWso7aj01cj3KLiFSBeFXMjQPzgwpaiXUF3W1hVx6dyxcE9G7
 AiYTXbj8p4ZzQ2W7lJ0Y7US99LchCCMw4jf8tlNSKlDzlIvTjsJRfT1ijQmvc8ljzGi5K4WZW
 V5hW4zC+dVGBP8HA7hSttRWoudZFA+REf4S3rV7CI+y6L2iM7JIuk4GqNLXchLSEG/1s6lRek
 bsHguDA9EaNw3c9OrFecmOX34EZ+UZt04vEiJi0OeDc3IcvnmlSfGxjjHzUOPeqEw07DS4wkD
 jy1Z3XHlA2YOsBHBzVySHVOSUMYzmIFU83Vbmka36bo3Pp40EZCk8S5DQBWhVHZhXr31TWwOR
 Y+nf8BGM9atKA1n47I5h06JcmnrsgsqqRx4YnxRvsYB3LiXhVKf/byDP6fiJvD4zTX0XUi2We
 OFxcY9hUV00yeTFw5+QPQFy3AAwUGvx72fRoUfXfxNtpc7FybMwhgHtDA82k/zUdFYJq0nl7J
 mEdWrHhKplgTRg2mUOOARf0VQMI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 14:07, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   7475e51b87969e01a6812eac713a1c8310372e8a
> commit: 4800a6215e335c6dade05e10c8fdbf919c04a3a7 parisc: Wire up eBPF JI=
T compiler
> date:   3 months ago
> config: parisc-randconfig-r113-20231115 (https://download.01.org/0day-ci=
/archive/20231117/202311172127.5PEz8XzL-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231117/20231117212=
7.5PEz8XzL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311172127.5PEz8XzL-lk=
p@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: missing ident=
ifier in declaration
>     arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: Expected ; =
at the end of type declaration
>     arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: got $
>     arch/parisc/net/bpf_jit_comp32.c:322:13: sparse: sparse: Expected ; =
at the end of type declaration
>     arch/parisc/net/bpf_jit_comp32.c:322:13: sparse: sparse: got $
>     arch/parisc/net/bpf_jit_comp32.c:323:13: sparse: sparse: Expected ; =
at the end of type declaration
>     arch/parisc/net/bpf_jit_comp32.c:323:13: sparse: sparse: got $
>     arch/parisc/net/bpf_jit_comp32.c:666:37: sparse: sparse: Expected ) =
in function call
>     arch/parisc/net/bpf_jit_comp32.c:666:37: sparse: sparse: got $
>     arch/parisc/net/bpf_jit_comp32.c:669:37: sparse: sparse: Expected ) =
in function call
>     arch/parisc/net/bpf_jit_comp32.c:669:37: sparse: sparse: got $
>     arch/parisc/net/bpf_jit_comp32.c:672:37: sparse: sparse: Expected ) =
in function call
>     arch/parisc/net/bpf_jit_comp32.c:672:37: sparse: sparse: got $
>>> arch/parisc/net/bpf_jit_comp32.c:666:36: sparse: sparse: not enough ar=
guments for function emit_call_millicode
>     arch/parisc/net/bpf_jit_comp32.c:669:36: sparse: sparse: not enough =
arguments for function emit_call_millicode
>     arch/parisc/net/bpf_jit_comp32.c:672:36: sparse: sparse: not enough =
arguments for function emit_call_millicode
>
> vim +321 arch/parisc/net/bpf_jit_comp32.c
>
> ceb0e7267693d3 Helge Deller 2023-08-17  319
> ceb0e7267693d3 Helge Deller 2023-08-17  320  /* extern hppa millicode fu=
nctions */
> ceb0e7267693d3 Helge Deller 2023-08-17 @321  extern void $$mulI(void);
> ceb0e7267693d3 Helge Deller 2023-08-17  322  extern void $$divU(void);
> ceb0e7267693d3 Helge Deller 2023-08-17  323  extern void $$remU(void);

This is actually a sparse bug.... "$" is a valid character with which func=
tion
names may start with (at least on parisc).

Helge

