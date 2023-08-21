Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73E78346C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjHUUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHUUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:46:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30613E;
        Mon, 21 Aug 2023 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692650787; x=1693255587; i=rwarsow@gmx.de;
 bh=NJhP7vamc3IXhRH7Uuzbots/04TXuuQ494Cjvt0gnQ0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=YIWJN1/VPKKgbt4Qrq6NSGJ1dnROSw2S3mIKyr+WjN8CRY4Mn/lGd9OVNfzn0L8Ou3cHJD5
 cfk8nVvmmillp22gXo8TMFXhtSRyrXY+iGL7pXaKdUunxJQcmFgWwBvoXjDUPRXpuSo5hgz/O
 QnQP025II2HLS5A7A7LlQkVc2pFFzjWwLrvzdaFFKV+tAJa+suXynq4+MLplLeB5PbMYprocv
 4krv5uRfGJv7DfEQLV5sAjqqsQ7bactXp9xaBp5jDKlnR5QInCmTNjpCL3mnc9ZNfPQ6wN6ah
 /AMm0JnshyAonnsob+cMXDTM/l95ihJlvBrkzM92NgMCXyCUS6YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1qN8830DPM-00OHa2; Mon, 21
 Aug 2023 22:46:27 +0200
Message-ID: <abd9aaf7-1a75-d478-c39d-d4e0ee2f6f5a@gmx.de>
Date:   Mon, 21 Aug 2023 22:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HyAAq9J03Tv9DRVD8I/DCNFlvG4AYoawX5+QDivWE5+e+wWWSnV
 2BnRdaDIsRy7hx9GWanhxrCFRJ+4N6HyfXrDULY6sUghRTqj3R7JR8jDBaMcISoAcpSxY15
 /6Mby0V3cs1XIU/wVPllURgEH9EgaGp6Wlfei3uJes0Np6uOgAdnLRvB3m/hfeR1fcSCuYy
 8wtPSAUm5HGhyIc+SmUWQ==
UI-OutboundReport: notjunk:1;M01:P0:YsUjhoLOZs8=;vVrS1D8QofswyOrtIX4fBh0rcLb
 9+xZnQE4ZflKEnCgpKrxarUFT1v4cWae0fsUrN59RYebJQ5s2t1xkQotTvaRbK3MDTL/au52I
 4HJyLoSKxGpSZ/SVHFVk9ZaQ3We75upVflH6hxbtUkvJoo/p8iXoWjvxz8xOBWKWpwope9Ayi
 uRQ5mg81snbjmlO6fMndpsn78Mn6HJ2I+9BUR4HCCbFoI8CSnTqKCd7EbREHL24Tzc/WipQRt
 ayAc/CL7fzlbhidktVCbW1ugsF/1ryagajSUAWJHuwM4jQP4xRFGLo3kVqkZYDwlBJ458bwiM
 58EZZaLkdkEyJSW6AzlutjYASHhf7I+FNmacV2T15ZAYPJbABa9OKmJ/0kHRg6ZLV76EbIDbj
 +JQmZTpwPgaUQSAvWRkJMzSkkNM+6azvwLz6ycR67x3zwz2zDbJ+1ydEJaRO5GKaTVjstuRLd
 LAJFzz79zZRLvDFkL+zVlwDFB4ZK5vSlPv7glDQqp+YXIdpDA22xWNnBWQHISFoBuQxCp7Va3
 P67pXbSSvxSgXa+83no1IdthWwsGRuQsbkj0t+5Aprj5khSB/iG2MrWU1AkKRfNnd5G9bjcH4
 YbR4amZfuQqyTHv1RnZ3Y+uVe+cQ7/zQ64ayKsPxCyiyigj/hPVHerU4gl5h1zkJi1SPKx9LZ
 xGhjdZUN+N+OuUrC5hkl0zIHtv/GxsWsRNDO6WVInjP9lHyo7DSkQWX2y7YIYgqoeGC0sdEIP
 RhsKVSYFzBbHjZYqTet3MFdva4Rc6KcZ32yV3fSbJRpyhLwbFwhGV7PUC8o/Ht1YSUXKTPvWF
 bbNWKlrWK/IazVAviCd1vhUXtmcBAO/TC9kgw7FVhz4tAJs9lC7vNMzOXOuEiEAfugavfGaEK
 ofr0WxhgN9eS3qR1S1ngTP8aKrtQAhFoQd0aufrbz1EMqem2MhGo2XllV9IF03PYJiHLJQei/
 O3g4ejX2fRu9aIsxVQTR2C2Kmsk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.12-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

