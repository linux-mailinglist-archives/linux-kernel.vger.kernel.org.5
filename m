Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980817896FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjHZNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjHZNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 09:47:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88BE5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693057635; x=1693662435; i=toralf.foerster@gmx.de;
 bh=COCB5ncjdNZMQxmsXiT0e8hGerXd5xl3QcIC2OWYStg=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=dX+YTfBAijpd6eV53TwQIatK81odMXo4QU9dUeescZwttf/YS64C+QaSwAUC1sfoeTVzDbP
 9j3Hox/s54RI6so8i+KkBK3FV9cUEk67Y0iZ5Y52zpVVYDrWI3UMtvC8CprqiV/5sEW2UQZkn
 1EVdjM0vYnjcr5etexGENDw2wbaG+QcoN2/+zVCuTeyQen9ULIJZNPrI+PV9gEv6YMIfYJaMJ
 NVPgcdZz5HXjbmz11Fv75JgaLkIzcom4YT6+nJySt/zgwqJ86r+QgBTazFnIhcAZkFXwr3nVK
 y3716//uCCBhiFxXE6u9x+69q5ViUCE+W//6ZDbqZF7lPDkU6L4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([95.119.156.240]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1q33vP3Pom-00fyZ9 for
 <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:47:15 +0200
Message-ID: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
Date:   Sat, 26 Aug 2023 15:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SHJebWupHP6bUSOl975XN6Qj"
X-Provags-ID: V03:K1:eGtHq53NPRauDlnhBCkQUtPYowwRXEfR2IDVSK8OoqRqB4APeWI
 rAmyxVOFUP5Kfves6VbzvKGh0+XEks6lLGWypTAfbnLgaFP7PmuXRNqJLJrFHgSZq9+izeu
 YNYc7R2gQjmJVuNJdgfvxNwnGHJwn2U9C9oURt9F3Kt3v7dQS6lKC2uK7uuHJHr42XlHCDj
 TlOS5WXkpYITEQEopfHDw==
UI-OutboundReport: notjunk:1;M01:P0:ZwKrt48UGa4=;sTemlmZ/aSDKKUkKvBc01basZPZ
 SIvHXWQCRjG98SWOsMqICR9uIreS0COO+XU39cm9ATXKRCCXgMfRphqNl90g/2T6mMcObhyho
 zuXFPEIEpKFsShrl2Vr8PPm3tCgezpHOzdu4uMU74e/d+ucyC7XAnrFdpLv1SLK2D390Ay94Z
 16KI1apjZvs7/IKdN/2Td3HpKdsgy4Wg/aeuYM+RmLSKsEQSYRuSBKK0fAS/9JFxxxM61S2rN
 qFt6QW1faR0CYrzWaRDGc4WiM/RT+tzYGb2kCnB7NqAGIG7fPzbRZEBqmz07K1yqXBh3wz/S1
 wmKRzvi2AX4rSZlD6jdqrGMEuqiIA6QXM1PjzJxb1oLpcFl3WviP716+fLVwNbgZXr0euoZF/
 j6inf7jo/hzI4rJt8eI74ydkmBKijJGrIpfG0k3Q6rD8FYXcwecXlWDfSTqxMFdMYcjycp/wm
 FN7C47afwu6GZH31rOHPiRV/7ACkhGalxmG/DZ9EIVwyY/FZhQFzQvxqJibsqGX7/z3tnjn3/
 4TRfXR5hsqjf87BKevl1NDovMdKgzmMSuLt/yMsGu4g+xBDGWKstBvX0wAwGIZP0ADG4926yY
 Ut+9BPpG6hovdFnLg/n62Uwcta5UHGTehNTzA95nGKVr6YomUlbgtLLFS+R2Qkj2cmQ3SgH6+
 E7Im2tCWblMXFMyz88LfkHQ95SE/mLnSdXOo66GUP5A7evm66ZijEulM0tD5xU/i6U6PfdR9A
 yC/f08873n5FYXc9IVg2lnDo6KGoPopMr0WxHisTeHeYN2dpiYPbjcu4QHJQN+VKJeU7zjBFb
 HLguid85K3j3jI4fxFwr91O4yKtixD82hvpIAu8ODbBUofGnWMw3+6s6kds+mqdiH+GQHlRN3
 Cav4SquEs0tpZSjNnsY6va2bcVl4rVvmndI1MfjWxZ/6jCLCQnQR1klpfCEN6pNNQhDLgPnpA
 IEvqzg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SHJebWupHP6bUSOl975XN6Qj
Content-Type: multipart/mixed; boundary="------------bgZnVJkyjcSMytzjYEa20PTt";
 protected-headers="v1"
From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
Subject: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210

--------------bgZnVJkyjcSMytzjYEa20PTt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpJIGRvIGdldCBhDQoNCm1pc3NpbmcgcmV0dXJuIHRodW5rOiAweGZmZmZmZmZmOTQ4YTcz
ZmUtc3Jzb191bnRyYWluX3JldCsweDAvMHgyOiBlOSA3YiANCjkyIDM1IGZmDQpXQVJOSU5H
OiBDUFU6IDAgUElEOiAwIGF0IGFyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jOjU3MiAN
CmFwcGx5X3JldHVybnMrMHgxZTQvMHgyMTANCk1vZHVsZXMgbGlua2VkIGluOg0KQ1BVOiAw
IFBJRDogMCBDb21tOiBzd2FwcGVyLzAgVGFpbnRlZDogRyAgICAgICAgICAgICAgICBUICA2
LjEuNDggIzM4DQpIYXJkd2FyZSBuYW1lOiBMRU5PVk8gMjFKNTAwMkZHRS8yMUo1MDAyRkdF
LCBCSU9TIFIyM0VUNjBXICgxLjMwICkgDQowOS8xNC8yMDIyDQpSSVA6IDAwMTA6YXBwbHlf
cmV0dXJucysweDFlNC8weDIxMA0KQ29kZTogMzYgMDEgMDAgMGYgODUgZjcgZmUgZmYgZmYg
NDkgODkgZDggYjkgMDUgMDAgMDAgMDAgNGMgODkgZjIgNDggODkgDQpkZSA0OCBjNyBjNyBl
OCA3ZSBmZiA5MyBjNiAwNSAyMiA3ZCAzNiAwMSAwMSBlOCA4YyBhOSAwOSAwMCA8MGY+IDBi
IGU5IA0KY2YgZmUgZmYgZmYgYzcgODQgMjQgODEgMDAgMDAgMDAgY2MgY2MgY2MgY2MgNDIg
YzcgNDQgMzgNClJTUDogMDAwMDpmZmZmZmZmZjk0MjAzZTAwIEVGTEFHUzogMDAwMTAyNDYN
ClJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmZmZmZmOTQ4YTczZmUgUkNYOiAwMDAw
MDAwMDAwMDAwMDAwDQpSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAw
MDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KUkJQOiBmZmZmZmZmZjk0ODg2MDFjIFIwODog
MDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANClIxMDogMDAwMDAwMDAw
MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmZmZmZjk0ODg2NmU4DQpS
MTM6IGNjY2NjY2NjY2NjY2NjY2MgUjE0OiBmZmZmZmZmZjkzYzAwNjdlIFIxNTogZmZmZmZm
ZmY5NDIxOTExOA0KRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5N2RjZGVl
MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KQ1IyOiBmZmZmOTdkNmY0YzAxMDAw
IENSMzogMDAwMDAwMDIzNDIxMDAwMCBDUjQ6IDAwMDAwMDAwMDA3NTBlZjANClBLUlU6IDU1
NTU1NTU0DQpDYWxsIFRyYWNlOg0KICA8VEFTSz4NCiAgPyBfX3dhcm4rMHg2Zi8weGMwDQog
ID8gYXBwbHlfcmV0dXJucysweDFlNC8weDIxMA0KICA/IHJlcG9ydF9idWcrMHhkYi8weDE0
MA0KICA/IGhhbmRsZV9idWcrMHgzYy8weDcwDQogID8gZXhjX2ludmFsaWRfb3ArMHgxNy8w
eDgwDQogID8gYXNtX2V4Y19pbnZhbGlkX29wKzB4MWEvMHgyMA0KICA/IHJldGJsZWVkX3Jl
dHVybl90aHVuaysweDdlLzB4N2UNCiAgPyBhcHBseV9yZXR1cm5zKzB4MWU0LzB4MjEwDQog
ID8gX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4ZC8weDMwDQogIGFsdGVybmF0aXZl
X2luc3RydWN0aW9ucysweDY4LzB4MWUxDQogIGFyY2hfY3B1X2ZpbmFsaXplX2luaXQrMHg0
OC8weDlhDQogIHN0YXJ0X2tlcm5lbCsweDc4OS8weDg3Nw0KICBzZWNvbmRhcnlfc3RhcnR1
cF82NF9ub192ZXJpZnkrMHhkMy8weGRiDQogIDwvVEFTSz4NCi0tLVsgZW5kIHRyYWNlIDAw
MDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpoZXJlIGF0IGENCg0KTGludXggcDE0cyA2LjEuNDgg
IzM4IFNNUCBTYXQgQXVnIDI2IDE1OjQxOjA0IENFU1QgMjAyMyB4ODZfNjQgQU1EIFJ5emVu
IA0KNyBQUk8gNjg1MFUgd2l0aCBSYWRlb24gR3JhcGhpY3MgQXV0aGVudGljQU1EIEdOVS9M
aW51eA0KDQpPdGhlcndpc2UgdGhlIGtlcm5lbCBzZWVtcyB0byB3b3JrIGZpbmUuDQotLSAN
ClRvcmFsZg0K

--------------bgZnVJkyjcSMytzjYEa20PTt--

--------------SHJebWupHP6bUSOl975XN6Qj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABEIACMWIQQaN2+ZSp0CbxPiTc/E6s3eAHbpTgUCZOoCYgUDAAAAAAAKCRDE6s3eAHbpTpvD
AP91Wbx0TCvxUeEqTm4OjbjATAn2w/PY37uO8XZMBvkpZgD/fFQdHTP8hQv0kospGUdGNzfSg0G1
C92ZsJbJftCOWHA=
=cY3x
-----END PGP SIGNATURE-----

--------------SHJebWupHP6bUSOl975XN6Qj--
