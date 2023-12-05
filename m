Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28628044D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376449AbjLEC0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376593AbjLECZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:25:56 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5A1BE4;
        Mon,  4 Dec 2023 18:24:49 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B52LvLp005594;
        Mon, 4 Dec 2023 18:24:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3h9Esgf5fSHZZ81EBKXoZrFOSOldeYw+NU2mpbbzteg=;
 b=mdrKPqCVEOL1COQ9UxHOaDeTFD6n91vxKcwdMuOrVWc7Mi/WKGFlT4qKQss/IFgvzQv5
 fRB5cm4mP3Jk/Of2svZ0NhlmcwqLXo8EsQXcfCot96M6vdxEElEPz+ED71MPT0uwh1Bu
 rANABZuzyV+/saAGKemJvvrEwwjCmGBwVkN7u44xFM5rbs1bWZODP2IQVVn6sn2YIKKD
 pHXcGnaA72g0lgc08wUDuTzWwmQAvlSNkApumIe/T5QrFcqLAGdmtRcIGgYs05HYMGTh
 q7AH2U9TPoZa+5ayq4nIzYn4iQPlg9di3yZ7o9hJWQm5vzjyBShqA3S86bX5IYy41tFR 6w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ur43m9mbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:24:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701743084; bh=3h9Esgf5fSHZZ81EBKXoZrFOSOldeYw+NU2mpbbzteg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QTgn3bRI9bnw9zOxuRnsQfB9ELsh0zlJmTR6tCHXbusg/QZLe+oj5KJOxRDl6qcWT
         z0yLowLaJRYqWDIbflJ0pKSh+/xWA66ScGAZhYvEC1+iA/z93FsfBfH/yW5AtHhrSo
         s1DIfQ58RtMrzUndkT6Dx2dNvRo48jybpRKCVhCyBN3YCXsCrFD9KwCH/mkUFC0VjW
         xH+3CGQDTZfXcPegRgEyYppnHmFBRQ95x1bDqRfIr2VcB3pdcZPkPdFMAQYkWya0jF
         Fh07IZQcZbj+4acohXY8fcH67pCV53WoCFGBLE7wTnhy4S2zKc0frJy45cJOxasmVd
         WdNvxIpdlLHdw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F177E401C4;
        Tue,  5 Dec 2023 02:24:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B3046A009D;
        Tue,  5 Dec 2023 02:24:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rTnMWVE1;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B91140130;
        Tue,  5 Dec 2023 02:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZtPlmz8bAzUIJ7Qeq/M1VgERWf0OJfswvS4B4Dl6Za+71tFEvFEbhjyuklDQogDTZasomMGYiwKaCS9gfVjLVMDsnkLgdrjjRqWXkn7oGZARJGPnjSXLvAZMRMAtzKbKB0MZ9zjTRaY/Hdm/tAoYoRBqc9YedHUh+Lnr/EZRcX4XDZU2HhrRj2RaHt+3z95nUYpq2WxIo7gWIpHzWRzo/KQXkUTwb71irdj3D7eF+Xzdd6yHLjOcyxdJcql9mqeGRH7SK6fnt/UcGP4EV+ao4EUO0iYjoDZl6pMLCJHVLlef7Ee0GIQhffY4Zhs+dK6T8HIbtNpHuHgpepeRqCvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h9Esgf5fSHZZ81EBKXoZrFOSOldeYw+NU2mpbbzteg=;
 b=ih1e+4cdV6P9WjCxpEaSJnhN3fnKtKQpVpcTeDJhfCxUHo0e5ITBj5VTkhNC/MZSHknVOWDJ1aye+sipsRGmQ5hgDLn3buuuEaoEQqcFPpo+K3eF+Q62ykwjIikanLPJFkZxYyW2oDkOqXvj8gTYLaB26sBjBGAQ7tOd069mQzYK4KHbCZSnBRp5BC/v1pOVa5ry0plY1C9ouRIZ3Da4dJBzdW6ZdGKe9mCA7jh05AskGJf5A+8TxWp6HqV4NdIzm0UmCzvNAhB3RaoBJt4zY+EG8l7I3qSmfw92N6Qr1w67+hfqUneEMsgf5pO8n4eKSqmth2tHFSn1V5t/lMw02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h9Esgf5fSHZZ81EBKXoZrFOSOldeYw+NU2mpbbzteg=;
 b=rTnMWVE1OI9YZ35a+QA0ERpUEP35VLEeyZ8dMzOVpj6jwqeTi2KC8CE66HldQaOmOqn0jNyuhpiETe2DFiRjEvaWgb8i2T2XAzeVn8JlQdF0iAbLLVEy02/DPb+n1ZLm9AzW1A+fm9IokqWlLZ6QwJW1G4yaxtU71fQkNNEmnfY=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 02:24:40 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::f330:9717:9bb5:9a13]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::f330:9717:9bb5:9a13%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 02:24:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Topic: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Index: AQHaEfz2PCHK7ZBtXUSxW0d9mtOpUbB0OfMAgAUeRQCAIMgoAA==
Date:   Tue, 5 Dec 2023 02:24:39 +0000
Message-ID: <20231205022430.rpdpgk4les7psp52@synopsys.com>
References: <20231108043441.2103940-1-piyush.mehta@amd.com>
 <20231110233810.ojsvcg3tqmim3lzg@synopsys.com>
 <MN0PR12MB595381B6BB4BA353060A677BB7B2A@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB595381B6BB4BA353060A677BB7B2A@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|SJ0PR12MB5634:EE_
x-ms-office365-filtering-correlation-id: 2fc1fe4e-1e23-4a9f-9e84-08dbf539550a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOwBq9TlgBE/DM9Mx8FAqLRalIogyNA+e+351jNE9Be7Gfw+3+Gfj58rLxsKJ4ymHOEEiiHZiO/WrrgiFlsUqZ0n6cKpv09AYL14rAiJJSNowXg3WMxWgH47sFzitlOgkIVjoqMcbdhX6XH6lpgdXhb8JavRYmq9ZH87ISOZenKJWjDMbh70KzUZ+Y8tuYo9kPz4ldJSwQ4c3mJgnXYG3WZlvuBadRK9NzFZ/PWVHg0OibWN4zS/cZXHrO47fWLzyAxC9lnyCBicVuZTYBHewyWlvUcBS7P/QX6upmx/oyq6Zs8gwFZi1fFcnavC9iZDXMKrkiU+TY9Rxz06cSovpF9+9XeWeMpMV0+D/7YWAY6cMPXEkSboHIw5fuoIN4sVk6ov+vtruiWEUy4alDmjRTC8CAMXMylECb+pJ0i6+p5Em/1CkqAzViOVNwbTn8juCFsJwDBvLmc6CpyMYSfyLQMDrDxRDipqFZE49nCtugSM5WLTO9gTAkuIjLlAYYRYTG9PFt9cxgnYaQNGS++7R2F1g3MAO8F586jaNDxxhtlhH2gHn7AhnVKzJ7vQAnZvYrcMFd3S3XSJwjz/DoIQ7SG0W8zNwTD3s8bYsDQmD4AdPFmnWx9esi9f2IFH+JUT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6916009)(54906003)(91956017)(66556008)(64756008)(66476007)(66446008)(66946007)(76116006)(4326008)(8676002)(8936002)(316002)(6486002)(478600001)(71200400001)(5660300002)(38070700009)(36756003)(41300700001)(2906002)(86362001)(83380400001)(2616005)(26005)(1076003)(122000001)(38100700002)(6506007)(6512007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUcvVFRndW9FczF3OWZvTjZ3eDd2YWlUb2Z2aGV2SStMN0s1OWxreGFYUlBI?=
 =?utf-8?B?ZGt1T3c5Nmpib0xwOEVUVnNpbWE1ZWJXODNaejVtUVphWGt0L1BUeUM0cmx6?=
 =?utf-8?B?QnBVaEZneVFFbnNKMEFqYzJXdGhxdmxhVk9aSkRxc2gvRSsxQkdlTW9HaEMw?=
 =?utf-8?B?bGpHY3JsSUp4M0FqMWtFL0k5MldJTUNFYjJ0cFQ1TnU2YkMzQnhPSFMvQnJh?=
 =?utf-8?B?OUNMYStWdDJWbGh0dDVvNFpvcGZXQmNHZUFWTjNQZjdBaXpSeDRiaUdWNXRE?=
 =?utf-8?B?QVdFdkdkdkV2RCs4M1V1UXQ1NGlsL1hGNXJDR2pPZ3ROZ016NDhLbFE2NU1I?=
 =?utf-8?B?VHh2bkFFdnc1cklPUGVHSkJCY3hOQW5FWVN6aENDVFQ3bFQvRU51Vm5ZYXBM?=
 =?utf-8?B?cWNPMG9XU2JIM08zTnhQYnA5cEZJdXUxaGF1WWVEdXFpUW1SbmhETUZLVHhV?=
 =?utf-8?B?Qk9wdEQzTDVaM1dwT2pCSVBYeEErRzJtSWIzZEJvd1F1Tk84dFRhRlNEWFMy?=
 =?utf-8?B?NWg3aXYxekVNQWZQa0NNcml6NUt6SjN1YUZPRzUxMFhGS1h3dWtiZGJ5ekdv?=
 =?utf-8?B?b0x1OHU5Kzg2aC9jeEcxZjJIUUNWam5adUJveHlhRTNJUDV6UTEyNHpyYTJl?=
 =?utf-8?B?WDYwMGk1MkMwNHRrOTVtLzhFOGt0RkgxL2xXMUFZM1lpSDFYU0d2dXBOYXEz?=
 =?utf-8?B?Nm1hTzM3b3JuYmdpZWJqMjNWdWhJOHEwWTZOSWJzTUtBOGhGOU1yRDBzL2x6?=
 =?utf-8?B?K2NncWFTMFZGUlBRankvQWM0c2tCUnRYcGVIbVRObUhvZ0V6VW1XaUpSaHhX?=
 =?utf-8?B?dDRIQzY3KzVCK1BxNTNGVHpxckl6RE8xWUhLa2h5dXJZSytEcVFkMXA0anhL?=
 =?utf-8?B?aEtzc0hrWThIOHJuZVN0Uy9yVDFnL3NxZ3U5Z2J6azJyQlFaK3F0UnQwMy84?=
 =?utf-8?B?K1VhaEx6NHNoQ3pBc0VobG4wdnBEL3VNN2FhcGlXcHBjck5CbU9sK0NBRzZk?=
 =?utf-8?B?ZFc1OVVkSHU5MGxqaUdhU2hsU1kyTU0zb3RrYUNTYW92ekFiOFBicHdmMnNN?=
 =?utf-8?B?amQwTUhoN0VpVGlNbm9zc3d0YkVPa3p2ZFhxWlBwNE9wOHQ4NzRteWU3QUp5?=
 =?utf-8?B?SmFyRnN6RjVtb3l1dlRjVjdxSWtJdnFXNnozMFA2VGUzVW5GemRmK1BoMHBE?=
 =?utf-8?B?dFgzbEN5U0VsaG5SWTFPOGhXd0VtNHpHd01RWHlpVGNyZThFZEt6ZzRNK25O?=
 =?utf-8?B?VGFuS0ZGSS9JdGtUaVFpa01JYnRVUEQrSy9zNnVBQmZadmFyeUZycjhiOUI4?=
 =?utf-8?B?cEJITnRaa3M4K1JpK2pRQmJ5M3NZWDFRY2tWelowZ2ZTZmVhb05TTEwyOW8z?=
 =?utf-8?B?R2gyRXVKWEpydEFDMXZoZ2o0WkZxREVxWUovN1V0R2VRVnpySlJlbVdGZm1X?=
 =?utf-8?B?cWpnQU81cmxTV0F2Sm5zLzJUNDNXeHVlL2VUNVloSUxmSWROdlFmWFlCU0xn?=
 =?utf-8?B?M0dPV0R0em9BKzNmMHdkUm5zWTlSWkN5Lzh2MGZTa1ZNRmd6VlA5WFd3UnNw?=
 =?utf-8?B?WjJiSW9RUjRRdTU4VWpIb3BPZnhzNGM0cWJMYjZ3ZVh4Y2lRanV5blFUcjR3?=
 =?utf-8?B?ZEEwUUw0R1doSS9CS3hkOFl2YXF5VzRoZzVjM2c0WFZsS1FzQ3FEZGJ6dzVu?=
 =?utf-8?B?OFhHOWNUMzRMblRVQlRmdWNHcHhub3l0M3hQTGRyLytXNGlUcnBTeEtRNjVU?=
 =?utf-8?B?MzUyS2NnY2xjQnRaTzJNNEFVZU1lcm5wRm1QbXZ5VUJKNGZiVWdjZmx3QVJ2?=
 =?utf-8?B?ai9VZmFzUGVaQU9OSU1la1ltekVxcDBTSzlZTVpKclY1eGt5KzBOa2s1MUhC?=
 =?utf-8?B?U00wclZKS01TV1ZRSjNrYWpGK1ZCL3Vjc1RMclpweDJ6VkV4T3JENTdiSnFN?=
 =?utf-8?B?UGxxNXgyZVliVG5aai9maW5pZ1BOVS9GRmQzS0xqMVJ4RVp0RTMyNlN0cksv?=
 =?utf-8?B?UE5majlaQTBsdXBQL3FoSzdrTzBPM3dEa1NJV2RXWnBSeHVDSnBudkRIUjV1?=
 =?utf-8?B?dE4zVTAvRlk0NmZ0Z2F6TXYwVloxS0ZlWDQzM3ZNR0ZJSVBzUDlmN0liMWRV?=
 =?utf-8?B?RGxVMTdNekxIMXgzMEFPUGVsWjJTYnNFcy9WZnJ0N01TbTVObjJsM2g1Wkhq?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B940F2F76EE941AE377290EF205036@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WDxVcD26llWhUF7jnVn5XYhmbEM9Pq30gPx7chPX6jWdRJ6bkedzXsGFzDYpMrNdFOi8DxgUJkiawjqrytez3HJ3naSgSlJDH4KS5GkIGKmKiNVij40e3v1aWs/pi3WsqZKW8KPmpPZ8BiaXB/Jdv9o+Y9GmsRl7DJ1RUh3gGebtWdBK8lMOXGFE724SZbpuadErVOctkXkhZ4scFu1ayeDdPBQYCuXpgQ8JAV5c7ac0UEg5QeG7kFEviejqHQwTsTVG5+O6+4dKBBki5EJzr8Cyw8O3hwG3tn0rzNlVxNIC9X2VFXkhYvDJQeEvUeOIYXOVHgkDze8LqBy+Trl+Cv0jIGsXaRwbE+TQj3zAE4SVHxfxAbcBliUka1Y0q5O5P9/haPy5pV7HzUkYM/K4eSmLeBHBeIQHrmGoxbs1ugkVP05ahobRE32z/PrSIdGhX/2mXFxR4I9IrEgVaqav12ZhkZ/Ty/H0TU7NN8vAfchGhT/rTd6i1RL3jDxCRTBQz5n3/TjVFAGHQ7Z0GQg+z74Vrev6hHT61MxY2nCmgBS7OYJHhZIwfrJ+3r8tw75HVrSkPxh90ouJRDvZdgIrr2BFxW0alLnPmUrgn51y6LR0AQQcqr/PQamlDUnnyCMsFjfzW0Qcs+JiERTPwLKqOD9Qgov8ZP/YiRYL/CgbflGpy5vwSSew2gYOaQ6qCPFN3MiIwERtX0Hlsb+iSI3e5rLALMR43/5o+MotkIe2yz6ULla/CQ07GvDgJx3ox2dFkzYKizSi0Gsjq081WgyQz50VOyUKvlQQ30YirP2KOLg6ytFkkgpE6b/EKWZOpMv941t+b/xQE3nm9WrF1y18JL7Iv9eyG4ixu0RZkO3JC12ZPepYhWgzuTHdmxciYpt
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc1fe4e-1e23-4a9f-9e84-08dbf539550a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 02:24:39.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgB2dbjx2uB4qIiZOui5fVmHQik8tt4dGoeiiDIDjYopiJijaUqBVhWqJFKVQFaJMyHUS6LWdp4qwwRlvk0IIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
X-Proofpoint-ORIG-GUID: uFy8IIYmqtNS57NT0aiFkIMwWnKywI-l
X-Proofpoint-GUID: uFy8IIYmqtNS57NT0aiFkIMwWnKywI-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=856 suspectscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheSByZXNwb25zZS4NCg0KT24gVHVlLCBOb3YgMTQsIDIwMjMsIFBh
bmRleSwgUmFkaGV5IFNoeWFtIHdyb3RlOg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+
IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAxMSwgMjAyMyA1OjA5IEFNDQo+ID4gVG86IE1laHRh
LCBQaXl1c2ggPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0KPiA+IENjOiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiA+IFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47IGxpbnV4LXVzYkB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiB4
aWxpbng6IGltcHJvdmUgZXJyb3IgaGFuZGxpbmcgZm9yIFBNIEFQSXMNCj4gPiANCj4gPiBPbiBX
ZWQsIE5vdiAwOCwgMjAyMywgUGl5dXNoIE1laHRhIHdyb3RlOg0KPiA+ID4gSW1wcm92ZSBlcnJv
ciBoYW5kbGluZyBmb3IgUE0gQVBJcyBpbiB0aGUgZHdjM194bG54X3Byb2JlIGZ1bmN0aW9uIGJ5
DQo+ID4gPiBpbnRyb2R1Y2luZyBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlIGFuZCBlcnJvciBsYWJl
bC4gUmVtb3ZlZA0KPiA+ID4gdW5uZWNlc3NhcnkgQVBJIHBtX3J1bnRpbWVfZGlzYWJsZSBjYWxs
IGluIGR3YzNfeGxueF9yZW1vdmUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGl5dXNo
IE1laHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
dXNiL2R3YzMvZHdjMy14aWxpbnguYyB8IDEwICsrKysrKystLS0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gPiA+IGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLXhpbGlueC5jIGluZGV4IDViN2U5MmY0NzZkZS4uOWNmMjZlOWExYzNkDQo+
ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0K
PiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ID4gPiBAQCAtMjk0
LDEwICsyOTQsMTUgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfcHJvYmUoc3RydWN0DQo+ID4gPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPg0KPiA+ID4gIAlwbV9ydW50aW1lX3NldF9hY3Rp
dmUoZGV2KTsNCj4gPiA+ICAJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiA+ICsJcmV0ID0g
ZGV2bV9wbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiA+IA0KPiA+IFlvdSBqdXN0IGRpZCBwbV9y
dW50aW1lX2VuYWJsZSgpIHJpZ2h0IGFib3ZlLCB3aHkNCj4gPiBkZXZtX3BtX3J1bnRpbWVfZW5h
YmxlKCkgYWdhaW4/DQo+IA0KPiBUaGlzIHdpbGwgZml4IGluIG5leHQgdmVyc2lvbi4NCj4gPiAN
Cj4gPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gPiArCQlnb3RvIGVycl9wbV9zZXRfc3VzcGVuZGVk
Ow0KPiA+ID4gKw0KPiA+ID4gIAlwbV9zdXNwZW5kX2lnbm9yZV9jaGlsZHJlbihkZXYsIGZhbHNl
KTsNCj4gPiA+IC0JcG1fcnVudGltZV9nZXRfc3luYyhkZXYpOw0KPiA+ID4gKwlyZXR1cm4gcG1f
cnVudGltZV9yZXN1bWVfYW5kX2dldChkZXYpOw0KPiA+ID4NCj4gPiA+IC0JcmV0dXJuIDA7DQo+
ID4gPiArZXJyX3BtX3NldF9zdXNwZW5kZWQ6DQo+ID4gPiArCXBtX3J1bnRpbWVfc2V0X3N1c3Bl
bmRlZChkZXYpOw0KPiA+IA0KPiA+IFRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiB3aHkgc2V0IHN0
YXR1cyBzdXNwZW5kZWQgaGVyZT8NCj4gDQo+IFN0YXR1cyBpcyBzZXQgdG8gc3VzcGVuZGVkIGlu
IHRoZSBleGl0IHBhdGggdG8gdW5kbyB0aGUgc3RhdGUNCj4gc2V0IGJ5IHBtX3J1bnRpbWVfc2V0
X2FjdGl2ZSgpLiBUaGUgaW5pdGlhbCBydW50aW1lIFBNIHN0YXR1cyBvZiANCj4gYWxsIGRldmlj
ZXMgaXMgJ3N1c3BlbmRlZCcuDQo+IA0KPiBUaGVyZSBpcyBhIG1lbnRpb24gb2YgaW4gRG9jdW1l
bnRhdGlvbi9wb3dlci9ydW50aW1lX3BtLnJzdA0KPiBGb3IgdGhpcyByZWFzb24sIG9uY2UgcG1f
cnVudGltZV9zZXRfYWN0aXZlKCkgaGFzIGJlZW4gY2FsbGVkIGZvciB0aGUgZGV2aWNlLCANCj4g
cG1fcnVudGltZV9lbmFibGUoKSBzaG91bGQgYmUgY2FsbGVkIGZvciBpdCB0b28gYXMgc29vbiBh
cyByZWFzb25hYmx5IHBvc3NpYmxlIA0KPiBvciBpdHMgcnVuLXRpbWUgUE0gc3RhdHVzIHNob3Vs
ZCBiZSBjaGFuZ2VkIGJhY2sgdG8gJ3N1c3BlbmRlZCcgd2l0aCB0aGUgaGVscCBvZg0KPiBwbV9y
dW50aW1lX3NldF9zdXNwZW5kZWQoKS4NCj4gDQoNCklmIHlvdXIgaW50ZW50aW9uIG9mIHRyZWF0
aW5nIHRoZSBzdGF0dXMgb2YgZGV2bV9wbV9ydW50aW1lX2VuYWJsZSgpIGFzDQp0aGUgc3RhdHVz
IG9mIHBtX3J1bnRpbWVfZW5hYmxlKCksIHRoZW4gdGhhdCdzIG5vdCBjb3JyZWN0Lg0KDQpCUiwN
ClRoaW5o
