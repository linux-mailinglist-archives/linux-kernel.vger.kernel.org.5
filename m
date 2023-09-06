Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C50793368
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbjIFBc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjIFBcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:32:55 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9CCDE;
        Tue,  5 Sep 2023 18:32:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38600AUM013914;
        Tue, 5 Sep 2023 18:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ltpXNU13Civc59YbL67sFfDvQcKOMVbnwfMOftNCM6U=;
 b=LlywqHK/dAgH3S2G7X1hbYp6PoLWaQJNn85CuLC+acZ/Mm9h8hRlyLkQ3Tq7eb2hNL8l
 ouEeufJ0z1au+h2jDHS+CVt+vtKdlwgbJtmjbt7HAg6wc+RZF323QZZrizAy0aQEdAm+
 wJyrfhCPy5cMxqVDda0stn3f73JkaV8KwX0YRmrEhVYCo62+GZiv/0JnOqMRFmVWOgZc
 2xTqnMsy7L7oIHkK1nBEw5PE/AIbqsvqBlH0WyFzZg3naS6IL5eNEJ4V5VDW8bZ/IaL5
 kLmcQvBy9vRYnU8jCjvfmxaBeyRRxPMZH6OQmCciUbFMabv7D9JFSu0q8bWdni0vg4yE wA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sv4a5dvse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693963948; bh=ltpXNU13Civc59YbL67sFfDvQcKOMVbnwfMOftNCM6U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J1+KFjGjwdNQa3ryby8wNV6DHIui1j2Q3wdKRRiTKyIg/DfMdDEyVIToiYeknb1Y4
         xlJm8LJDM06fkv80QfgDfZHbMhnmtwXh8VvTamjEOzsCNmJRgo98VcaWfDDvx2DDhg
         wVHqweMK8KP+eujDcRpch9nuBg8EOizz1LB8yHmvaYmS0RMg9+JbmQZjOmEq46CwF1
         AUK/26er4Bl/2Uz77KV9IymVZanB678wiBaRoEOeWjcu9iYXeJFGWz0d+C7/lPLDE/
         TqVGngIyGNxss/E2xJPpOv6r8BpD4RJ/Nm9n3U/VL4zCncNuF8wogMzkEGT5unPbes
         zo9n1sEeLN8jA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 47DA54013A;
        Wed,  6 Sep 2023 01:32:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 70E0DA005C;
        Wed,  6 Sep 2023 01:32:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nHfwLOeZ;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4B8664059D;
        Wed,  6 Sep 2023 01:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjYug8uQjTy7eue5hb9Fzo4l0RJ5r4yWb+L44XSvZLJC1RVBzEDFnpH0oDNFmgiJtVIQb1a255eEFroJRcU8NfhosBkxSb95KmwLqkDNWVO7cQbjN/mQzq/ETiZvhywymLuSf9IwHR1Hk475M50JMLFhEWnFVY2sIcZaM3QpfNeghL9vcuM7Mn4LfpAHi5WZO6a7tthkQRcaLLC8zfk9Yl7ocpSSmuDZUZp1WCaJMjsn/F4mVcB5ySypV6GWJ7X/7mUTo/t+gtY8jazypzHzgVfCOzqBK/IX1vnUfLfEUjwdc8zTfReWQzo9LfbZPfiZRqn/zP7QjZV6QVMRzHLugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltpXNU13Civc59YbL67sFfDvQcKOMVbnwfMOftNCM6U=;
 b=lAAY3+jIc5tP5gSFocPtmxVfy3ynvEkqQAe/gF0P40eQVUec56Sg3ly4CfusAhQ3WxMXVs51wb8IiobsttlRdU65yig4j3pSP3uNOcbVCO8MfOq4ircKLyuQvvB/CGn6DSj9a0flH5VPG+d4RTxowKSNfmoJe6zrBxh41k1TQQuynnVHjwfNFIotnX8SF2DMpwd4f0pWEek2nM1AxD8mchstbshZv21ax7U1AaEsL0EVaK1XBa1FPpZ+VvZhyfUFGdArnGk8Km4hTMWXFDdvPBbo0S2HmAoMO2zDcc68tTB7c+H6XS19wMOgrBTu/KMZSEUP7/o3yTyV3eqs8eSOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltpXNU13Civc59YbL67sFfDvQcKOMVbnwfMOftNCM6U=;
 b=nHfwLOeZQfMpOCmkf0S1MiHydSq0EeEnmoCOcknZAfhYngP57LDCkPh+sVby69lZBws2ClxOGMVslq9wJ6b7ph/Wuxm8RQu0+VzC/LdhVTloWhXNlcsWB2S/pWvuJIL1Bal7MyY7ISBpNXDbYljzYcJj7chKTPXk+Rh1N+sukz4=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 01:32:22 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 01:32:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Kenta Sato <tosainu.maple@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: usb: dwc3: some USB devices not working after 6.4.8
Thread-Topic: usb: dwc3: some USB devices not working after 6.4.8
Thread-Index: AQHZ3sHpFemvEWcgE0y6nzvaTFcKdLANBmOA
Date:   Wed, 6 Sep 2023 01:32:22 +0000
Message-ID: <20230906013209.jlcxluxemyg3va6l@synopsys.com>
References: <CAF1eZtsBzGb_UxOqZpNiEsk8Uk7DkqPh5AnYRRNc_kkr-tFasQ@mail.gmail.com>
 <ZPUciRLUcjDywMVS@debian.me>
In-Reply-To: <ZPUciRLUcjDywMVS@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|PH0PR12MB8151:EE_
x-ms-office365-filtering-correlation-id: 0d5d21c0-76d6-4078-9e7a-08dbae791e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wa/Ss7/GxqEG6eZuqH3/1djM8/gU6EGzzoeBRwn8b6dksNMmqoKUhnZsigBezFufR3pw22+Qu9I9+oaYZWg1egLWkhfkVBdgyJtlp1dNDYWa/IepUIHBj4wPWBFIHkUiNYw/Ui4LnoYUIJifKAY3aB5fJpbGIsnJ16R0xZ3XdM/iKhKjj/xSP/+lpmLfQ01fDhsPmXvU16+HA6nMtnajCbQv0ftn4ZArw95ZEfxNkVP0QZmKd23DnsQcaZSlvZQ6O/41lpYgBkVV9UdSyQX2k9ix+i138vjBdn3a9TNqCrUeybD5Ftn3oRlX0KilB+ixCRxnaSE/L7ic0ihMeLfqpaddIIecZH/i1mzbBOxzhjYapj4UhjodBhUT4VEnxP+WBWlc252XIwTnrhmd0dHYeIfn8dVrSElBLxMlXZx2/vQtD4HUW7e58pp0lu5yDb1/MzC57+FHVUhKpt8M0/KAN0lU0lwz4hdXxXLrZHJa5jPxzop6XphiV6m6kxgv8cErI5VNvjPhZjT09v6H/xQqldAeRJDdjHijox/Ibvfdt2kRPuMMQK/5jr480KesHi1ttwPHIKPPtGk/oqBP3K9O2xsDv3jF5bl05TKXdxkBgqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(41300700001)(316002)(76116006)(66446008)(66476007)(66946007)(64756008)(54906003)(66556008)(110136005)(91956017)(8936002)(4326008)(8676002)(5660300002)(2906002)(122000001)(38100700002)(38070700005)(83380400001)(6512007)(53546011)(2616005)(26005)(1076003)(86362001)(478600001)(966005)(36756003)(6506007)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGxsa1UzNmJSTGh1Nm43MmlJTVJjWTIzWXJpQzlVeVIvVC9vWXVQZTh0ekxR?=
 =?utf-8?B?SGRnekNVNVUvNkprdmZvRFVabVUwV0thc2oySG1GWWpEWHJzVEdPdVlHY1U1?=
 =?utf-8?B?Szh2TnNMYnhLSXBubjJSdlNlN3pEUk5QWmhWT0ZiRktuNjJFM1BzTU5RQkU5?=
 =?utf-8?B?NGdZV2tBTmxhb3JpQThZS1FGbVljUUljeUY1a1BJOW1FeVB3TGdJMHp5VFEy?=
 =?utf-8?B?ZEh0OVMvd2FpTWs2U3AzVmJ6NThwWlFvcTQzaWg5MGUwSFNvMHYySVdaTDdz?=
 =?utf-8?B?OFRlSFNObVFSSXoxSmxqWTVpdHZlaGVNRzFUWEQxTmFYN1ROajZMbTJxa0Ft?=
 =?utf-8?B?eDI2K3Bweng1UWQxaUlYMHgyeXhFa0xsU1dRQW5FbDFzSnlPV1lFU2xObWo1?=
 =?utf-8?B?RGxQTllWWW8xV3JEc1lucUpoVmZSRjZQNlc5akpFem5ObzVFUklXQWRPQUt5?=
 =?utf-8?B?MjFjalNFYysyL3NxV3E3TndxQjJybFRPTnhiS2NMY0E0Zi9WQjA1Wi81R3pN?=
 =?utf-8?B?VU41ZFg2N3RkeFM4VTdUcTY1UHVIVGNxSW9mOFJjOUh1NWREeThSVy9OZXJr?=
 =?utf-8?B?aThhd1RHcFhwRTkySkNCWFBwUFQ3bnprUG1RK2pkSFdhZTdSNWxCL0RTM1RL?=
 =?utf-8?B?K3VwQnB0Q1RzeUtldkg3djVNNVAyMlZuQTFaemFQRnpmYjJTcGVSeVArL2lj?=
 =?utf-8?B?WEdFYzRUeVppbVREVi8vOEZqMFdBRHh2R0lpNnY5VU5nSHdtUXFsUkhKUm9q?=
 =?utf-8?B?dVdrWCsvanRXMGxwY0NlbEVTRi9rbDR6dlN6YkY4WUxGQUI2NUZydkRiVDRR?=
 =?utf-8?B?TUtZdEU2MkNYRjJHZXg0T1ZDaFVqd2lvUXVXZFRNdjVBNVNid1FZYU5CQkdk?=
 =?utf-8?B?NnRnSXp1aE8vWG91eXBHM3lkNVZwZXR6OGNiM2VqR2ZldWdUT0lBVXpNYnRh?=
 =?utf-8?B?TTl6OURvWHdXRDBaTVNDZ0R6dUhiekwycmFRTW1EMmduU1A4cHRzYmhIenFF?=
 =?utf-8?B?azZYZXFUWGtYMWNldzlOVnJkVjEvUFJiUEtPbkdEQmw0Y0VOaUVTSG9KMjE1?=
 =?utf-8?B?L0NVRGlTQlRVUkFNc3BzZWNnWFZaOG55b1g1V3NRRS9aSjJwaDRGK1lLWFJj?=
 =?utf-8?B?akVYYVVlOXdBcjM2WGYvZEh5c3BDY1hzZitZNHkyN1hhejc3MEl1YllLbnJm?=
 =?utf-8?B?eWV2TG4vSUZvcWlWdTRnTzJrWHJ0aW52YXJBUGVud1R3STNZZ2U1UWJ4R2Ro?=
 =?utf-8?B?NlBJSDJiaStKdlBseU9TWERzY0kxanJFdU8xVm9yT0taa2o5K0taeEVrQlNi?=
 =?utf-8?B?YlJsZlBNWFBtT3N3U3A5VUI4Z1RtbjltdWJCMWZkZFM5NjVnS0hvb0lpQ1lX?=
 =?utf-8?B?YUdHNEFLQTMvTk4wMGgrVzNSZWtrRHZHWW42RThTQ3JHVnFKSS9iUk9heVNQ?=
 =?utf-8?B?WTVEQ1V1UDZ2ZHI2Yk0veVcvTnZ1R0RKU3hQSFEvUTRVRzUyaWV4Z1dJWGh1?=
 =?utf-8?B?czROQXBGVE1HNTBuclFKamxSTUlOZFVIblhlK0Fjd2lqSGpJR0RKbnZHQXlO?=
 =?utf-8?B?dlZKdjFHWStybHNPSkY5MXFyemF4dmV5OWZLcmNDME56NW10WGtLeXhLdUtl?=
 =?utf-8?B?eC9XZm5YRW9BTDdVakVCNEFoNUVsRS9kRXkwLzBtdkpvZURWWDFOMkZZWk9F?=
 =?utf-8?B?eU1zdm5pUm9oNFo0eDRaZWhVRGZ0OXA5ZUhUcjB2TnVGRDNkVWpMSWVBajUx?=
 =?utf-8?B?ajNpclRvcjNZcDVhK2FXVDRyRDFqUTRnMzc2WmY4eUF5ekZSbWNJa3FtYkpC?=
 =?utf-8?B?MnB1OGlsMkl4cGhWQU1NcDU3YXVnRUs5RXlJNUpMTU4vRHdrWVRVNUV2UDlt?=
 =?utf-8?B?cjdpdDYvR3JMM29hK05zeitBZW5JeXdJSjlMKzhKOTBLaG8ybmpFd0hPLzZ6?=
 =?utf-8?B?Nm1Qa3FUZGd6Y2dpbGM1KzdITDhDbFFDNkNsVWF2dnNVRy9LeS9uWEhaMlE5?=
 =?utf-8?B?NzlDSzh0Q0R6WUlwTGtHckkvNGlIbUh2SWpNTkEvMGV2ejQ5NmJQQ3h4MlN3?=
 =?utf-8?B?NGw1UkFNQkxhRHUrdmN4THdiQTZjRGEyb21CdGdabmR4R0R0Ylp3OVEwdER3?=
 =?utf-8?Q?oryhQWyldw6BXfQvgR4JokVGW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39B74DEA4D240745842C03B1FE13E177@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RmJ1eFhFR0xUbEdpVm9RSnBUK0d6bFJEQ25GY2VnU0RNb0Q0VkZHMksrT0J5?=
 =?utf-8?B?Y0cwMzRSYjI0UWxVTFI4eHI0SzB0WDRpSXUxb0FUTFE3dlN1VHFOZU9SL1U0?=
 =?utf-8?B?S2p1M0lIaGV1eUw2dWVJYzhoNlhBbHR0bER1MnorQTVCdTRFQXJTNElZVXlE?=
 =?utf-8?B?UlFRK0U2NmdYYVM2SEczSW95T21sdGYxQjk3dVBaTDE3cUdTNDkrMm4rTG41?=
 =?utf-8?B?OW9GM08yRVVsdmp6MVBzWGo2L0tGZCtlcldWRmZ2b2l0KzZOYnBVZGZHMFR1?=
 =?utf-8?B?Uk5sbWtXRG1FZTAyMVc3Ri9aczl2VUFZMFZZN1Rjd2xYU28rSmJmL1Qzb3d3?=
 =?utf-8?B?bk55ekVCZEVCUGRqYWoxNlo2SElEanZnWGYyV1JtdVUreVJKRVhROUhRMTNR?=
 =?utf-8?B?TWJ4YzMrQjJwaDVMN0w5YnBsbURpY2xHWGJ0MFUwT0VzcXI2MGJZMTZDVnBF?=
 =?utf-8?B?RUdycFdVV0dQRW8wOU56ejZvdUNwNXRuYnR5ZisvZmUzaWZJVm9jaVlJRkIw?=
 =?utf-8?B?NmJyaTA3WXI0WEZHSVh5bXE2TjE2NDRZR3JrWVA2cEZDdXl2Mm1LSXhLa0FY?=
 =?utf-8?B?RXhQdmhXTFVBMXVnTlI4RTJoZVdwdkVIU2k1MkZrQnJvS3NnbmM2eFNxeXJm?=
 =?utf-8?B?YjV1Rm5MZjZreWVPcWRsSHIxN0k2RFU1dzc1S2RIeWtlN3dOZmVWK2dSSGZC?=
 =?utf-8?B?eHZ6YmdScE9FaFpWbEV3TmZxZVhGd3o1ekVxL2VrYjNkaXVReGVjT1dPVk5J?=
 =?utf-8?B?ZmcxYTNWL05CUWtQeE1iRWVWaHJkQlRKZ2FKTUJyS01BZWN3bkdubXVKMWNY?=
 =?utf-8?B?SWpQMHpXU0Fta2ZxTzBUbnR6SGVCTHpTV3JQaGdZWDBEMEYwVjhWTHdWdng5?=
 =?utf-8?B?dk1Lc1RmNHpRNzJoNUtNdXE0NGs5TkVqWDduNGIyQzExcVZHWnJCa0wybmtx?=
 =?utf-8?B?ME84YUVCWTRuc2JWUkduK0I4NWdoYUV3emZ2My85bERSbUl1bis5VmlhcFhw?=
 =?utf-8?B?TnZZMEJncnRUQTJsL2N1cVg5M0owZUxmdTJNbGNuYnBNdWZqN3Z3VEVOUU1D?=
 =?utf-8?B?T0dkQzFVdmtneGdndSs3MzdlTndkRWdoTkppZ01uTWZrSFd0ZlJreTRyVEpi?=
 =?utf-8?B?bndCdm5Ed3BaU0dnOUN3Y1cxRnlTQjN1ZjQ5dnVDQXlhbFE1RE9wdUVZNkx3?=
 =?utf-8?B?OFk2Q0JzUnljZnU1N09jenM3M29HeHdHVnpOSEplQkRpTUVBc0RYdWd1Q0xU?=
 =?utf-8?B?YzZ0MDdYbzNzRk1EUFhpNkcreWZhU2t6NXRvUHlORDBvSUVYZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5d21c0-76d6-4078-9e7a-08dbae791e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 01:32:22.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DTCPww3LyK+T0rySjkXAiOGGOjSaA6Soyf9EIxjnDEwyecGICBYLkmJ52d3PryxIgBBKIXqtnHoSIgyV/khmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-Proofpoint-GUID: R6FVRfp4Me-KK7QQjP7icesXHHGrcoKy
X-Proofpoint-ORIG-GUID: R6FVRfp4Me-KK7QQjP7icesXHHGrcoKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMDQsIDIwMjMsIEJhZ2FzIFNhbmpheWEgd3JvdGU6DQo+IE9uIFN1biwgU2Vw
IDAzLCAyMDIzIGF0IDA5OjE5OjEzUE0gKzA5MDAsIEtlbnRhIFNhdG8gd3JvdGU6DQo+ID4gSGks
DQo+ID4gDQo+ID4gSSBhbSB1c2luZyB0aGUgRnJpZW5kbHlFbGVjIE5hbm9QaSBSNFMgYm9hcmQu
DQo+ID4gV2hlbiBJIHVwZGF0ZSB0aGUga2VybmVsIGZyb20gNi40LjcgdG8gNi40LjExLCA2LjQu
MTMsIGFuZCA2LjUuMSwgaXQNCj4gPiBkb2Vzbid0IHJlY29nbml6ZSBzb21lIFVTQiBkZXZpY2Vz
Lg0KPiA+IA0KPiA+IFRoZSBib2FyZCBoYXMgdHdvIFVTQiAzLjAgcG9ydHMuIEkgY29ubmVjdGVk
IDEpIEJVRkZBTE8gVVNCIEZsYXNoIERpc2sNCj4gPiAoaGlnaC1zcGVlZCkgYW5kIDIpIE5FVEdF
QVIgQTYyMTAgKFN1cGVyU3BlZWQpIHRvIGVhY2ggcG9ydC4NCj4gPiAxKSBpcyBvZnRlbiBub3Qg
cmVjb2duaXplZC4gT24gdGhlIG90aGVyIGhhbmQsIDIpIHdhcyB3b3JraW5nIHdoaWxlIEkNCj4g
PiB3YXMgdGVzdGluZy4NCj4gPiBSZWdhcmRsZXNzIG9mIHdoZXRoZXIgYSBVU0IgZGV2aWNlIGlz
IGNvbm5lY3RlZCwgSSBjb3VsZCBzZWUgdGhlIGJlbG93DQo+ID4gbWVzc2FnZSBvbiBkbWVzZzoN
Cj4gPiANCj4gPiBbICAgIDAuNzQwOTkzXSBwaHkgcGh5LWZmN2MwMDAwLnBoeS44OiBwaHkgcG93
ZXJvbiBmYWlsZWQgLS0+IC0xMTANCj4gPiBbICAgIDAuNzQxNTg1XSBkd2MzIGZlODAwMDAwLnVz
YjogZXJyb3IgLUVUSU1FRE9VVDogZmFpbGVkIHRvIGluaXRpYWxpemUgY29yZQ0KPiA+IFsgICAg
MC43NDIzMzRdIGR3YzM6IHByb2JlIG9mIGZlODAwMDAwLnVzYiBmYWlsZWQgd2l0aCBlcnJvciAt
MTEwDQo+ID4gWyAgICAwLjc1MTYzNV0gcm9ja2NoaXAtdXNiMnBoeSBmZjc3MDAwMC5zeXNjb246
dXNiMnBoeUBlNDYwOg0KPiA+IFJlcXVlc3RlZCBQSFkgaXMgZGlzYWJsZWQNCj4gPiANCj4gPiBJ
cyB0aGVyZSBhbnkgaWRlYSBvbiB0aGlzPw0KPiA+IA0KPiA+IFRoZSBjYXVzZSBzZWVtcyB0byBi
ZSByZWxhdGVkIHRvIHRoaXMgY29tbWl0LiBJIHRyaWVkIHJldmVydGluZyB0aGlzDQo+ID4gY2hh
bmdlIGFuZCB0aGUgaXNzdWUgc2VlbWVkIHRvIGJlIHNvbHZlZC4NCj4gPiANCj4gPiA+RnJvbSAz
MTdkNmU0YzEyYjQ2YmRlNjEyNDhlYTRhYjVlMTlmNjhjYmQxYzU3IE1vbiBTZXAgMTcgMDA6MDA6
MDAgMjAwMQ0KPiA+IEZyb206IEppc2hlbmcgWmhhbmcgPGpzemhhbmdAa2VybmVsLm9yZz4NCj4g
PiBEYXRlOiBXZWQsIDI4IEp1biAyMDIzIDAwOjIwOjE4ICswODAwDQo+ID4gU3ViamVjdDogdXNi
OiBkd2MzOiBkb24ndCByZXNldCBkZXZpY2Ugc2lkZSBpZiBkd2MzIHdhcyBjb25maWd1cmVkIGFz
DQo+ID4gIGhvc3Qtb25seQ0KPiA+IA0KPiA+IGNvbW1pdCBlODM1YzBhNGUyM2MzODUzMWRjZWU1
ZWY3N2U4ZDFjZjQ2MjY1OGM3IHVwc3RyZWFtLg0KPiA+IA0KPiA+IENvbW1pdCBjNGE1MTUzZTg3
ZmQgKCJ1c2I6IGR3YzM6IGNvcmU6IFBvd2VyLW9mZiBjb3JlL1BIWXMgb24NCj4gPiBzeXN0ZW1f
c3VzcGVuZCBpbiBob3N0IG1vZGUiKSByZXBsYWNlcyBjaGVjayBmb3IgSE9TVCBvbmx5IGRyX21v
ZGUgd2l0aA0KPiA+IGN1cnJlbnRfZHJfcm9sZS4gQnV0IGR1cmluZyBib290aW5nLCB0aGUgY3Vy
cmVudF9kcl9yb2xlIGlzbid0DQo+ID4gaW5pdGlhbGl6ZWQsIHRodXMgdGhlIGRldmljZSBzaWRl
IHJlc2V0IGlzIGFsd2F5cyBpc3N1ZWQgZXZlbiBpZiBkd2MzDQo+ID4gd2FzIGNvbmZpZ3VyZWQg
YXMgaG9zdC1vbmx5LiBXaGF0J3MgbW9yZSwgb24gc29tZSBwbGF0Zm9ybXMgd2l0aCBob3N0DQo+
ID4gb25seSBkd2MzLCBhd2F5cyBpc3N1aW5nIGRldmljZSBzaWRlIHJlc2V0IGJ5IGFjY2Vzc2lu
ZyBkZXZpY2UgcmVnaXN0ZXINCj4gPiBibG9jayBjYW4gY2F1c2Uga2VybmVsIHBhbmljLg0KPiA+
IA0KPiA+IEZpeGVzOiBjNGE1MTUzZTg3ZmQgKCJ1c2I6IGR3YzM6IGNvcmU6IFBvd2VyLW9mZiBj
b3JlL1BIWXMgb24NCj4gPiBzeXN0ZW1fc3VzcGVuZCBpbiBob3N0IG1vZGUiKQ0KPiA+IENjOiBz
dGFibGUgPHN0YWJsZUBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppc2hlbmcgWmhh
bmcgPGpzemhhbmdAa2VybmVsLm9yZz4NCj4gPiBBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyMzA2MjcxNjIwMTguNzM5LTEtanN6aGFuZ0BrZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9m
Zi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgu
Z2l0L2NvbW1pdC8/aD12Ni40LjgmaWQ9MzE3ZDZlNGMxMmI0NmJkZTYxMjQ4ZWE0YWI1ZTE5ZjY4
Y2JkMWM1Nw0KPiA+IA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmVncmVzc2lvbiByZXBvcnQuIEkn
bSBhZGRpbmcgaXQgdG8gcmVnemJvdDoNCj4gDQo+ICNyZWd6Ym90IF5pbnRyb2R1Y2VkOiBlODM1
YzBhNGUyM2MzOA0KPiAjcmVnemJvdCB0aXRsZTogc29tZSBVU0IgZGV2aWNlcyB1bnJlY29nbml6
ZWQgY2F1c2VkIGJ5IG5vdCByZXNldHRpbmcgZHdjMyBkZXZpY2UgaWYgaXQgaXMgaG9zdC1vbmx5
DQo+IA0KDQpXaGVuIHRoZXJlJ3MgcGh5IHJlY29uZmlndXJhdGlvbiwgd2UgbmVlZCBmb2xsb3cg
dGhyb3VnaCBhIHNvZnQgcmVzZXQNCnNlcXVlbmNlLiBJdCBtYXkgYmUgZG9uZSB3aGVuIHdlIHBh
c3MgdG8geEhDSSBkcml2ZXIgdGhyb3VnaCBpdHMNCmluaXRpYWxpemF0aW9uIG9mIFVTQkNNRC5I
Q1JTVC4gSG93ZXZlciwgbG9va3MgbGlrZSB3ZSBuZWVkIHRvIGRvIGENCnNvZnQgcmVzZXQgYmVm
b3JlIHNldHRpbmcgbW9yZSBjb3JlIHBhcmFtZXRlcnMgaW4gZHdjMy4NCg0KQ2FuIHdlIHRyeSB0
byBqdXN0IHJlc2V0IHRoZSBwaHkgaW5zdGVhZCB0byBzZWUgaWYgaXQgaGVscHM/IElmIG5vdCwg
d2UNCm1heSBoYXZlIHRvIHRlYWNoIGR3YzMgYWJvdXQgeEhDSSdzIFVTQkNNRC5IQ1JTVC4NCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCmluZGV4IDljNmJmMDU0ZjE1ZC4uNjYxODZlZjM0YzZkIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQpAQCAt
MTEwNCw5ICsxMTA0LDQyIEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMg
KmR3YykNCiAJaWYgKHJldCkNCiAJCWdvdG8gZXJyX2V4aXRfdWxwaTsNCiANCi0JcmV0ID0gZHdj
M19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCi0JaWYgKHJldCkNCi0JCWdvdG8gZXJyX2V4aXRfcGh5
Ow0KKwkvKg0KKwkgKiBOb3RlOiBHVVNCM1BJUEVDVExbbl0gYW5kIEdVU0IyUEhZQ0ZHW25dIGFy
ZSBwb3J0IHNldHRpbmdzIHdoZXJlIG4NCisJICogaXMgcG9ydCBpbmRleC4gSWYgdGhpcyBpcyBh
IG11bHRpcG9ydCBob3N0LCB0aGVuIHdlIG5lZWQgdG8gcmVzZXQNCisJICogYWxsIGFjdGl2ZSBw
b3J0cy4NCisJICovDQorCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQ
RUNUTCgwKSk7DQorCXJlZyB8PSBEV0MzX0dVU0IzUElQRUNUTF9QSFlTT0ZUUlNUOw0KKwlkd2Mz
X3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApLCByZWcpOw0KKw0KKwkvKg0K
KwkgKiBNdXN0IG1lZXQgdXNiMyBwaHkgcmVzZXQgYXNzZXJ0aW9uIHRpbWluZywNCisJICogc2hv
dWxkIGJlIG11Y2ggbGVzcyB0aGFuIDIwbXMuDQorCSAqLw0KKwltc2xlZXAoMjApOw0KKw0KKwly
ZWcgJj0gfkRXQzNfR1VTQjNQSVBFQ1RMX1BIWVNPRlRSU1Q7DQorCWR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HVVNCM1BJUEVDVEwoMCksIHJlZyk7DQorDQorCXJlZyA9IGR3YzNfcmVhZGwo
ZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKTsNCisJcmVnIHw9IERXQzNfR1VTQjJQSFlD
RkdfUEhZU09GVFJTVDsNCisJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZH
KDApLCByZWcpOw0KKw0KKwkvKg0KKwkgKiBNdXN0IG1lZXQgdXNiMiBwaHkgcmVzZXQgYXNzZXJ0
aW9uIHRpbWluZywNCisJICogc2hvdWxkIGJlIG11Y2ggbGVzcyB0aGFuIDIwbXMuDQorCSAqLw0K
Kwltc2xlZXAoMjApOw0KKw0KKwlyZWcgJj0gfkRXQzNfR1VTQjNQSVBFQ1RMX1BIWVNPRlRSU1Q7
DQorCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSwgcmVnKTsNCisN
CisJLyoNCisJICogU29tZSBwbGF0Zm9ybXMgbWF5IG5lZWQgbW9yZSB0aW1lIHRvIHN5bmNocm9u
aXplIHRoZSBjbG9ja3MsDQorCSAqIDEwMG1zIHNob3VsZCBiZSBlbm91Z2ggZm9yIGFsbC4NCisJ
ICovDQorCW1zbGVlcCgxMDApOw0KIA0KIAlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFNUzBf
TU9ERV9EUkQgJiYNCiAJICAgICFEV0MzX1ZFUl9JU19XSVRISU4oRFdDMywgQU5ZLCAxOTRBKSkg
ew0KDQoNCi0tDQoNClRoYW5rcywNClRoaW5o
