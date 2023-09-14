Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4879F7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjINCYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjINCYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:24:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC9A198;
        Wed, 13 Sep 2023 19:24:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F841C433C7;
        Thu, 14 Sep 2023 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694658286;
        bh=traoJTyA0GnqPdbwWPW0u5/RrCWzv703PFaKmzg6di8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dRyHjGtNk/YMdNs8cVw1m1xwaSlfoX1FLI8mKGuHqKbRjvbl4DsL2zH6HzoVPPOK+
         Y3kbkTH0465sd9jTzj1fnMgYYfrZNzpdnS65gTYg1/4mC/Q2wZNOCtVyRvHhE4Gs/r
         SGGnfV9OS4/KHHw3o9ShXK8Gk3DaYWqvLYSaWxO8JJp2ZU6WxCK3k3tPN5Dbt5FCGe
         y2L2/rYF69Wmi4xPHXT3gvEdF+xXlVakk7qi1SGYP2grIzBgU0su9DNxezx0fzkVoc
         I/7lxFn4d0T1jyDaIxdv0YMv7hgn8RehOIPVL0yOQb3H16ydC3h9lwSv2YxNy+zd2a
         eURdy2kSPknlg==
Content-Type: multipart/mixed; boundary="------------zPUgE2h3WJYekH07ls6McJAe"
Message-ID: <bed98fc9-fb84-4912-6c73-5b7db575c375@kernel.org>
Date:   Thu, 14 Sep 2023 11:24:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <b919c7fd-babb-5557-dd8d-c2b8bb428d54@bell.net>
 <4fee8886-daa3-fb03-f9e7-89358fb5fc38@bell.net>
 <b9ceba24-345e-20dc-783b-3759a9819359@bell.net>
 <10887293-fa2e-83e1-9305-487905a8afd2@kernel.org>
 <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------zPUgE2h3WJYekH07ls6McJAe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/14/23 09:29, John David Anglin wrote:
> I think the issue is with the root ST373207LW drive.  The console output indicates that the
> ROOT drive doesn't exist when the boot fails.
> 
> Your change only appeared to affect actual SCSI drives.  That's why I tried disabling CDL.
>>
>> Could you send a full dmesg output for a clean boot and for a failed one so that
>> I can compare ?
> I'll try to get this together tomorrow.

Please try the attached patch. That should address the issue with your drive.


-- 
Damien Le Moal
Western Digital Research

--------------zPUgE2h3WJYekH07ls6McJAe
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-scsi-Do-no-try-to-probe-for-CDL-on-old-drives.patch"
Content-Disposition: attachment;
 filename="0001-scsi-Do-no-try-to-probe-for-CDL-on-old-drives.patch"
Content-Transfer-Encoding: base64

RnJvbSA5NGQwNWNlNTFkNWM4YTZmNDczODNhZmQxNDEzNGYzYzc3OWQ4OWUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPgpEYXRlOiBUaHUsIDE0IFNlcCAyMDIzIDExOjA4OjU4ICswOTAwClN1YmplY3Q6IFtQ
QVRDSF0gc2NzaTogRG8gbm8gdHJ5IHRvIHByb2JlIGZvciBDREwgb24gb2xkIGRyaXZlcwoK
U29tZSBvbGQgZHJpdmVzIChlLmcuIGFuIFVsdHJhMzIwIFNDU0kgZGlzayBhcyByZXBvcnRl
ZCBieSBKb2huKSBkbyBub3QKc2VlbSB0byBleGVjdXRlIE1BSU5URU5BTkNFX0lOIC8gTUlf
UkVQT1JUX1NVUFBPUlRFRF9PUEVSQVRJT05fQ09ERVMKY29tbWFuZHMgY29ycmVjdGx5IGFu
ZCBoYW5nIHdoZW4gYSBub24temVybyBzZXJ2aWNlIGFjdGlvbiBpcyBzcGVjaWZpZWQKKG9u
ZSBjb21tYW5kIGZvcm1hdCB3aXRoIHNlcnZpY2UgYWN0aW9uIGNhc2UgaW4gc2NzaV9yZXBv
cnRfb3Bjb2RlKCkpLgoKQ3VycmVudGx5LCBDREwgcHJvYmluZyB3aXRoIHNjc2lfY2RsX2No
ZWNrX2NtZCgpIGlzIHRoZSBvbmx5IGNhbGxlcgp1c2luZyBhIG5vbiB6ZXJvIHNlcnZpY2Ug
YWN0aW9uIGZvciBzY3NpX3JlcG9ydF9vcGNvZGUoKS4gVG8gYXZvaWQKaXNzdWVzIHdpdGgg
dGhlc2Ugb2xkIGRyaXZlcywgZG8gbm90IGF0dGVtcHQgQ0RMIHByb2JlIGlmIHRoZSBkZXZp
Y2UKcmVwb3J0cyBzdXBwb3J0IGZvciBhbiBTUEMgdmVyc2lvbiBsb3dlciB0aGFuIDUgKENE
TCB3YXMgaW50cm9kdWNlZCBpbgpTUEMtNSkuIFRvIGtlZXAgdGhpbmdzIHdvcmtpbmcgd2l0
aCBBVEEgZGV2aWNlcyB3aGljaCBwcm9iZSBmb3IgdGhlIENETApUMkEgYW5kIFQyQiBwYWdl
cyBpbnRyb2R1Y2VkIHdpdGggU1BDLTYsIG1vZGlmeSBhdGFfc2NzaW9wX2lucV9zdGQoKSB0
bwpjbGFpbSBTUEMtNiB2ZXJzaW9uIGNvbXBhdGliaWxpdHkgZm9yIEFUQSBkcml2ZXMgc3Vw
cG9ydGluZyBDREwuCgppbmNsdWRlL3Njc2kvc2NzaS5oIGlzIGFsc28gbW9kaWZpZWQgdG8g
YWRkIHRoZSBtaXNzaW5nIGRlZmluaXRpb25zIGZvcgp0aGUgU0NTSV9TUENfNCBhbmQgU0NT
SV9TUENfNSB2ZXJzaW9ucy4gU0NTSV9TUENfNiBpcyBub3QgYWRkZWQgYXMsCm9kZGx5LCB0
aGUgbGF0ZXN0IFNQQy02IHNwZWNpZmljYXRpb24gZGVmaW5lcyB0aGUgc2FtZSA3aCB2ZXJz
aW9uIGNvZGUKYXMgU1BDLTUuCgpSZXBvcnRlZC1ieTogSm9obiBEYXZpZCBBbmdsaW4gPGRh
dmUuYW5nbGluQGJlbGwubmV0PgpGaXhlczogNjI0ODg1MjA5ZjMxICgic2NzaTogY29yZTog
RGV0ZWN0IHN1cHBvcnQgZm9yIGNvbW1hbmQgZHVyYXRpb24gbGltaXRzIikKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1v
YWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jIHwgIDMgKysr
CiBkcml2ZXJzL3Njc2kvc2NzaS5jICAgICAgIHwgMTEgKysrKysrKysrKysKIGluY2x1ZGUv
c2NzaS9zY3NpLmggICAgICAgfCAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYyBiL2RyaXZl
cnMvYXRhL2xpYmF0YS1zY3NpLmMKaW5kZXggOTJhZTRiNGYzMGFjLi42NTRlZTlhMGMwNjQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMKKysrIGIvZHJpdmVycy9h
dGEvbGliYXRhLXNjc2kuYwpAQCAtMTgyOCw2ICsxODI4LDkgQEAgc3RhdGljIHVuc2lnbmVk
IGludCBhdGFfc2NzaW9wX2lucV9zdGQoc3RydWN0IGF0YV9zY3NpX2FyZ3MgKmFyZ3MsIHU4
ICpyYnVmKQogCQloZHJbMl0gPSAweDc7IC8qIGNsYWltIFNQQy01IHZlcnNpb24gY29tcGF0
aWJpbGl0eSAqLwogCX0KIAorCWlmIChhcmdzLT5kZXYtPmZsYWdzICYgQVRBX0RGTEFHX0NE
TCkKKwkJaGRyWzJdID0gMHg3OyAvKiBjbGFpbSBTUEMtNiB2ZXJzaW9uIGNvbXBhdGliaWxp
dHkgKi8KKwogCW1lbWNweShyYnVmLCBoZHIsIHNpemVvZihoZHIpKTsKIAltZW1jcHkoJnJi
dWZbOF0sICJBVEEgICAgICIsIDgpOwogCWF0YV9pZF9zdHJpbmcoYXJncy0+aWQsICZyYnVm
WzE2XSwgQVRBX0lEX1BST0QsIDE2KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zY3Np
LmMgYi9kcml2ZXJzL3Njc2kvc2NzaS5jCmluZGV4IGQwOTExYmMyODY2My4uODkzNjdjNGJm
MGVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc2NzaS5jCisrKyBiL2RyaXZlcnMvc2Nz
aS9zY3NpLmMKQEAgLTYxMyw2ICs2MTMsMTcgQEAgdm9pZCBzY3NpX2NkbF9jaGVjayhzdHJ1
Y3Qgc2NzaV9kZXZpY2UgKnNkZXYpCiAJYm9vbCBjZGxfc3VwcG9ydGVkOwogCXVuc2lnbmVk
IGNoYXIgKmJ1ZjsKIAorCS8qCisJICogU3VwcG9ydCBmb3IgQ0RMIHdhcyBkZWZpbmVkIGlu
IFNQQy01LiBJZ25vcmUgZGV2aWNlcyByZXBvcnRpbmcgYW4KKwkgKiBsb3dlciBTUEMgdmVy
c2lvbi4gVGhpcyBhbHNvIGF2b2lkcyBwcm9ibGVtcyB3aXRoIG9sZCBkcml2ZXMgY2hva2lu
ZworCSAqIG9uIE1BSU5URU5BTkNFX0lOIC8gTUlfUkVQT1JUX1NVUFBPUlRFRF9PUEVSQVRJ
T05fQ09ERVMgd2l0aCBhCisJICogc2VydmljZSBhY3Rpb24gc3BlY2lmaWVkLCBhcyBkb25l
IGluIHNjc2lfY2RsX2NoZWNrX2NtZCgpLgorCSAqLworCWlmIChzZGV2LT5zY3NpX2xldmVs
IDwgU0NTSV9TUENfNSkgeworCQlzZGV2LT5jZGxfc3VwcG9ydGVkID0gMDsKKwkJcmV0dXJu
OworCX0KKwogCWJ1ZiA9IGttYWxsb2MoU0NTSV9DRExfQ0hFQ0tfQlVGX0xFTiwgR0ZQX0tF
Uk5FTCk7CiAJaWYgKCFidWYpIHsKIAkJc2Rldi0+Y2RsX3N1cHBvcnRlZCA9IDA7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL3Njc2kvc2NzaS5oIGIvaW5jbHVkZS9zY3NpL3Njc2kuaAppbmRl
eCBlYzA5MzU5NGJhNTMuLjM5ZjZiYzdiZmYwZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zY3Np
L3Njc2kuaAorKysgYi9pbmNsdWRlL3Njc2kvc2NzaS5oCkBAIC0xNTcsNiArMTU3LDggQEAg
ZW51bSBzY3NpX2Rpc3Bvc2l0aW9uIHsKICNkZWZpbmUgU0NTSV8zICAgICAgICAgIDQgICAg
ICAgIC8qIFNQQyAqLwogI2RlZmluZSBTQ1NJX1NQQ18yICAgICAgNQogI2RlZmluZSBTQ1NJ
X1NQQ18zICAgICAgNgorI2RlZmluZSBTQ1NJX1NQQ180CTcKKyNkZWZpbmUgU0NTSV9TUENf
NQk4CiAKIC8qCiAgKiBJTlEgUEVSSVBIRVJBTCBRVUFMSUZJRVJTCi0tIAoyLjQxLjAKCg==


--------------zPUgE2h3WJYekH07ls6McJAe--
