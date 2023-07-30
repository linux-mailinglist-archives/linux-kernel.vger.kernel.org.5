Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FAF7683EF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 07:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjG3Fyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 01:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3Fyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 01:54:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87AA10E4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690696481; x=1691301281; i=efault@gmx.de;
 bh=+hma6MdQ9WjJtS6MXE0P8zhJzFVSGULWBJ7mYhsoyUo=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=hGp8czQDDApUhXnd2s1LjQ7NdPHfSikuHyQaUEBbHCl9wEnOjbSE4y+hd3q07mlxsP+ozI+
 h4Ayokq0EYdhbovtVs5kczgg1wW7Ako0AynsHEYI4pxqg64vDRzDYkyuStfGZafPYnPtlITQK
 71vWy1CwGxHdPWvkYowpIwPl7m7LJTFXVcnODzvmDq+iE+NR6FYeKhHlz/T+oxEq+co06cDYT
 bbB81+6Ws8uw/QlTOgrcZ6YfxLdFG9rEzVq276sw9NTdkVj7I2Rv6io1zhwzSvducI7QnjRSS
 at7wem0Ocpl/FbpT9iN5/TaFxMN9rQUZrUasOll9aaCsUGPoVVJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.208]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1pgNdt3PAj-011991; Sun, 30
 Jul 2023 07:54:40 +0200
Message-ID: <069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Sun, 30 Jul 2023 07:54:40 +0200
In-Reply-To: <20230728141852.GA21718@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KSFeMMS+ugFubzoh4Z6xWJEuQ8yBvtbIUI1D53bYhmQhhTKVJN1
 1Tzfuv3uziW5spWdCTqmBX+IqqV8BEvRTb2EOMPcNu97iTJ6D2b7MLrLecDUqsy4NjNydJB
 abGAS52JSzZFPLYrKSpNjRKO+vqjNmJr7oYYcJVv175L3/G21pUiXTXwPGjXKQoBgQF+1nS
 Pf+dxM5r9uk5YZB8ZTopA==
UI-OutboundReport: notjunk:1;M01:P0:UB58QadFfqY=;8f4AP0oUh/mKpKKjPKc9X5uYVhW
 9HOja4umprKvUjyWRXQu0lvgltRS3TrfOVFLYut2SQoVkPRw/8NN/eUgpVUOKfM0AvEnwUd4j
 PTK+q90NhnwRkR+4gsNrKLBswBWtPpNtkz5I3qEDnj254gzyWB/FP+P4xCxUZ0X4gQAxikbx+
 OiWA+mg8+CUEbZy0UVrkcLAB1tnq1DV2+8cKsEQHLmrS2T6Zv9dZWRNQkLF0f2EyusfV5R5k+
 4SuXdaR7r7kJu4hG8NSGQlPRXecWvO7BmASuCSTO9tld1eVqZn0Md0o6C/JHX6zZqdb2JTee9
 5UDKVSWVRiqhqC1a6U+oPe28nUOWvT9HWY1NA/0/lyD6rji3KJDlbnDiVWsMVTQ5Tbz86jQTQ
 7uqOBxH+CCbq7agARuUAl9FS3v8gjATdnYF3lDYmTnHRCvLUUT8eyn2td9l6VYY0O5yljTwSI
 0oOT45z8hR+4ZZNXnGfkDwTiEAzLTEQ92LytP1ZD2PJGfzH7xM6CA63ps/G29fK05NWgNSRQH
 xSPKet8Ni7UhCD2i7xYdajYFPKWBayCOP41KFgFMiEgtQLHrBB9e85DKEM73HhMoocKwKGguw
 dxy7a+7bNTVV35nOBZwiZbRIYFpTE44AZvPOYKnY5Iizl63udGUiXukT+qOLiUwjMtebUnYjO
 6q/Xi07wt7lBgXRMh3TM5KxnOCdPCmKgGYyUz6UAhqwJ954NMy68LPCj3gJa3IzQiljJWmGeB
 D6fAdUAcYODIkFBgifzEPDF0AWdiGsZMDoyvxyyjTO7A+fmxLkDBdM2pl6hzrrH7Zs7ylDZrq
 8a2a85yIRf6PbGD+HCi1we0JDxk/ZDiWMKlR3ZXBDlt490hwlOhhuLjDNjsN7UoZBaCPrjwEF
 wOhPcXUrEQLoqRBtiO+P98RwqJoPF1HKrqx+d/d1pFa0vvzkDwgjQX/pqzLoE8iMczQq71ZPJ
 8oLqtCkw6OA1sNA3mx2cqcimO60=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
>
> Looking at this quickly with Mark, the most likely explanation is that
> a bogus kernel address is being passed as the source pointer to
> copy_to_user(). On a whim, are you able to revert 4c91c07c93bb ("mm:
> vmalloc: convert vread() to vread_iter()") and see if the issue persists=
? If
> not, maybe you can try the commit before?

Ok, did that.  Neither helped, I had to revert 2e1c0170771e

6.1.42 clean
6.2.16 not so clean
[  180.564427] __vm_enough_memory: pid: 1935, comm: objdump, no enough mem=
ory for the allocation
[  180.564445] __vm_enough_memory: pid: 1935, comm: objdump, no enough mem=
ory for the allocation
6.4.7  oops
+Revert-mm-vmalloc-convert-vread-to-vread_iter.patch               oops
+Revert-iov_iter-add-copy_page_to_iter_nofault.patch               oops
+Revert-fs-proc-kcore-convert-read_kcore-to-read_kcore_iter.patch  oops
+Revert-fs-proc-kcore-avoid-bounce-buffer-for-ktext-data.patch     back to=
 6.2 induced alloc failures
[   48.718233] __vm_enough_memory: pid: 1747, comm: objdump, not enough me=
mory for the allocation
[   48.718264] __vm_enough_memory: pid: 1747, comm: objdump, not enough me=
mory for the allocation

6.4.7 plus only arm64 revert (sorta) of e025ab842ec3 does the same
[   37.587688] Unhandled KCORE type: 0
[   37.611042] __vm_enough_memory: pid: 1736, comm: objdump, not enough me=
mory for the allocation
[   37.611073] __vm_enough_memory: pid: 1736, comm: objdump, not enough me=
mory for the allocation

=2D-- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -554,6 +554,8 @@ static ssize_t read_kcore_iter(struct ki
 			fallthrough;
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
+			if (!kern_addr_valid(start))
+				goto invalid_addr;
 			/*
 			 * We use _copy_to_iter() to bypass usermode hardening
 			 * which would otherwise prevent this operation.
@@ -563,6 +565,7 @@ static ssize_t read_kcore_iter(struct ki
 				goto out;
 			}
 			break;
+invalid_addr:
 		default:
 			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
 			if (iov_iter_zero(tsz, iter) !=3D tsz) {

