Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929D57815F4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbjHSAHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbjHSAHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:07:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B23ABC;
        Fri, 18 Aug 2023 17:07:16 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ING0O9002708;
        Fri, 18 Aug 2023 17:07:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=N/merUfdq/guNC4ZIU+z7cwxRbdj81B+/PZoMfQdtPU=;
 b=MRZ3+ftT07yPHvon8KC5nSTMk6k35QPb+eYaWPJmIOykHQdwcefb2rEFU+fGj4acuWgb
 I5YTlXaJi6OCLe1Y5strFTQNZ5T7IofMShsH42pSO9jl57WhEfAcrTM2lduIeWwaqjOV
 Oty83QijbGZN7x3aKJOo4ZCGi6+ldvLc4WP7fJGYPcxHBruidmXOjwjH++e4q/ZdLb86
 EZ76zIwewcPAcBYIK8lVBKILl8BzI/PjnmydF4yp0LrJro8oty2o2vCEMKy+eMiR0PnH
 CRlQMFGx/GxOY+AxYPp+VYoNJULiU8jc8o/3jOK4n91Cp45sExveip7dFReMQ/4Ow6Hi VA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se9b4eb0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 17:07:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692403621; bh=N/merUfdq/guNC4ZIU+z7cwxRbdj81B+/PZoMfQdtPU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=e3LUzvv19FFOiDsZwd4MxqJTSkdfpHjI6JuNrqvDVdzd7HPKgLEbpSpNOuugrpfeA
         64SGYilJFTGHdIn4V/iKpeZEXnFXe4qiO2GYoylo6LlqJlrdCjVZm7ako2s8tXUsHq
         j5/iB3eiSjVPDMixRoa4/KvABckE0cvObFdtc4/dOTlg9fxxFTUk+pEQPaAj0yhsIn
         +P4erkJ4afDerkydyQjVTsu/1JYcPJl8xIaL5oJx3cV8Wqmou1aKPgDBmliXgpPt74
         x+dLmCJ7a2JU9NvBIGdgeX9UPeWeETqbc879KPP+mvfmTYjlwz+hiqLdwurAf1SDWd
         dLH00cAv9aHhg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD77C401CE;
        Sat, 19 Aug 2023 00:07:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C8C40A0068;
        Sat, 19 Aug 2023 00:06:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hVsNsXPo;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6EE8C4058C;
        Sat, 19 Aug 2023 00:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJLZXj3ScB4w+T9bVi/WSE7mnnrLxYZW5Lg/rZGyulW6/od1sKZZ5iGxSunJNd+7IQEZJGqKBzl7YNH8cPPtPnYTjgtxPCU8LQqoFKSUzIDfYfSapK3JHLcuzq17834Sp4wob4v7ZshXhikvE3KEddIpNBOQ44fqas55TWATQ3y7l8Ec0ZAzCnacX2LrsuB+6nIM7RvFPi9pTA/+n1dyTDXgH0WC6Eg+0RbA49H/NFe9wuVcF+5hOvduXgRNILv/IwuLk6z7diTV/e7ZDuNWaiGTo5/piVuEr6lIzAqkpovEmwsJLjAfbC50Zr7fumCtUjEOkmOVfXD6Mfe7PUZcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/merUfdq/guNC4ZIU+z7cwxRbdj81B+/PZoMfQdtPU=;
 b=HG7jCxboMguogui9Bpvkx+tFjM0KayzZ5FWNKPjq6uMc20MK53ZJXoN184vFmHll2F7DtaEsb+C+HgrjpTEWB/l90GlxVBZjDLW9ym9PWPw0OZtvXpS7DXkB0JrYmpqyUCaOS37xljH4S/CV/QBqDRDpzDfm7T7nHytUhQmraQ3biVuEaz+m1UqoKLByTbv6HZRz+beKuqcmH5QRffwk5vbPFEonlSbmpBaCPKGjWsbJ3yycMAGYWOTeT0ALR88swQhwETLoRPC643jPXga+OMP6pFDW6/977x5G18MHsFVbjLO9sUdx6Mto7R1fROOdiXkIa0h45PshoyummPExJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/merUfdq/guNC4ZIU+z7cwxRbdj81B+/PZoMfQdtPU=;
 b=hVsNsXPodrFZ3XX37B8kxk90aGNSdboPMG7Q8NaDBdQ9aHGBpDkpC4GinNJ1uJdNOc1MrKycwkHRN9UcVZm7ONJtgpPhwYnB37C6H5b/ckkj4iyy+re+FWYik5G+Hm6F+1nWT23UYDNW7FDKv/Akk/vMlxes75/eDlOsJl1tEYk=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 00:06:54 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 00:06:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKA
Date:   Sat, 19 Aug 2023 00:06:53 +0000
Message-ID: <20230819000643.7mddkitzr4aqjsms@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
In-Reply-To: <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|CH2PR12MB4922:EE_
x-ms-office365-filtering-correlation-id: ff141d0e-adc4-4310-cca6-08dba048318e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inLYNU8IMSg8fAZKS22Wm2lw/JsYCICUXIYe5dJakLZwBbLbVVjzRAkoPAdYy5pnaQBpn+vpe2gr/mNs4OE1ykGRgNHlVdLraDa6jK64lvwIL3p+XtDYBjXvvO+H7xds2RXPsl3YRo9VimUPRZOEGksRX4jV6CJdV4Y6QXa+uoZAzJHpQeTVW24m0K8+aSKwL3r4eCIilY4esKzNJzONGwrZEyjsUGhoJY3kA7NhuEPOS52e6T5C6uYOhl/7P3LHiQNuj99Tfy3aE338HpcXg2YqR82YbZgu9sFyTpJlYDTtakzxDDUiQPkuTqjOGWWPNkDpKXoKKjHsYVMyQqWICqhKRIfor722a5Be0HbtzesLUB0fjJ6cGHFQj84h8iPTAeVGCe4/xUcA+gevLJpyfzsoh7zBbbUZtVPoyPODxQ4Iy0z1XBi+0NzmDxyRPLIB/PgbyLNDoxv7BXWgOr7ZNpc8eGfhuZ2h7cANDFueSWwUYBQkjIrQfs4Xe+rsNtd8nxARPVks0daPsDBSgjt7FnUXF912xWSs/ru5E06E0/HrkcoiSKtwrX6dJO/3Nu/JsbH4P83oZV3wZukbdznu6FYkMWyHnaL1K2TETx5K6zfXCeuOpyhjGNDfivaSpbOd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199024)(1800799009)(186009)(91956017)(86362001)(76116006)(64756008)(5660300002)(2616005)(41300700001)(316002)(6916009)(2906002)(66556008)(66946007)(66446008)(54906003)(66476007)(8676002)(8936002)(4326008)(478600001)(71200400001)(6486002)(38100700002)(38070700005)(6506007)(122000001)(6512007)(36756003)(1076003)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVjcVdiMmk2ZGU1RklLcTVqNk55TFpJVktBdkdFdHlTQVB4U2FjV00wU2xS?=
 =?utf-8?B?bWZ3V1ZGcnJGMllsK2FKbGZERnlwSGUzRFYydGVFcUNWbXFFc1ZRM3FEbGlo?=
 =?utf-8?B?aTlXalNYa0dmd3o1N0I4bFdheHRSVVdSSFhZWGdFeG1Na21VWHQvRm5Sd0dH?=
 =?utf-8?B?WEhIMGdtWDZVMmovUVpURGxGWThyMmJOVGNSYjBtVTBCZUFmbFRKZm5wc080?=
 =?utf-8?B?T1l1VFdmaTEwN3l0T1BGeC9ocmgyK3ZuRE5IcGtEOEdocm50YTlvQWdydU5H?=
 =?utf-8?B?L3lqeUtJaWRVanJtUys2ZUt0VitCSGF3R0VCUmp3MXVyWisrQ0NidXBZTVVl?=
 =?utf-8?B?V0o2enJiWGNqWmowSnFOcytNRkRpSVFLSFU2L0pPSGF3RU1rS0FDd09hR1ZM?=
 =?utf-8?B?d2x0cEFOcTQ2eHF4MmZDRWJvanF0WWp3ZmhtTlFmN0k4Z1VDN2ZsRlVac1VC?=
 =?utf-8?B?OERTN3Q2RndYVWc5TVpqK3hacm5EOXZvQzVSZzd4ZXJZQU1tVnN5akZCU2xl?=
 =?utf-8?B?UlljaE1OR01iT041VmVvWDVML1RraXE5QVB6YnNDcW5ObjZESGpLaWtKOGZQ?=
 =?utf-8?B?Skw3bVFOazE5TkNCNm0yaWthRm8ySHBVKzhwWWFZVFd4cnRSOEZKZEx0UDJG?=
 =?utf-8?B?Q0xraU9tWld4MVhFYnk1QXgrdmZydVd0a0p5UTNuTWc3WWVyaXZ4RUhqLytO?=
 =?utf-8?B?LzM4TkdMaUJxU3E5RE04d2VReHBKRkJod29ZTlFvaytXWC9nUGFJRE1YV01y?=
 =?utf-8?B?TGJIdUx6UUJvUndaRk44STJxNTM5ZnkyR05IVDFITFFXR1JxbUZzVEZaem1R?=
 =?utf-8?B?ZERNcGRoV3BENFRXTUIzUzBvOHVteW14M2tVNUpFZVJkcUtkMmJmSFNUV2R4?=
 =?utf-8?B?OHVaemdVbjBPOStSWURDWk16c1E5SllGK1BHbGdwOHhVV2RVbFVLNUw0SFZE?=
 =?utf-8?B?Nk8wSUt3ellXTEVQR0Rzbjh1bWdjbzhYSWt3SCtCRFJnQ0UwTmhGMDQ0RWx5?=
 =?utf-8?B?Q250Wm5VK3g3eityRWREL2ljaEtrK0JvS1pQa3F3WGlZRnNqTGhlTzEvVXV3?=
 =?utf-8?B?ejF2ZkZLRktDR1VPQ3Z3d2tEME5ITFJ5QkVuN3BOZGY3TDNFWDNBV2VYMkRr?=
 =?utf-8?B?RUNQeXp3aXVKakYza1B5ZE1kRkJ6ZlNCR2VUd2RnK1BLTHpXaUhlLzd0UHBZ?=
 =?utf-8?B?SjN6ejZxTFVLaHFHaE16SVEwSkduWDlucjhxOFU3QiswNFFwNXMvTndtNTVO?=
 =?utf-8?B?dWJDc1JwK1NlZi9ROTRFdmExdWtoYWxoeWlPTFFmbnVwellzdW56MVg5ZjVD?=
 =?utf-8?B?d3ZQbC9SaUxZcXB0ZW1TSUo1bUVPanovWndFNFNrbmhnbklLaWNTdGczU05x?=
 =?utf-8?B?cTVuVkI4Rk4rcHRkTlQvVTJDUGRNZndMOTJiNjJZby9OdGgxOFlaRWoxM3RI?=
 =?utf-8?B?OHllR1VMYU1DQ0haQ2dET1FUVTJqWWIyc2xtS3d5WTE2SWRsc0wwa2Nob08w?=
 =?utf-8?B?WVNtN3k3dEVXa044QkFEVENGeDlqL1FwdDhHVVh5VFVWdFZYN0cwbE9RVTFa?=
 =?utf-8?B?WHhIV2hBdDgvVTBxSlR6RVhZSTUrV0hFS0kvalJ4WTBDc2hNYm9SSkErSWRX?=
 =?utf-8?B?TGVlckZuMCtZb0Y0WVhtMkx2T0wrWnNzWDlpQjVGRVRFRlc4eDVYOGttOWo4?=
 =?utf-8?B?UmZkSjlVNHFBc2lHV3BEUTg2bit0YVRwdkdwb0gvZHFSclBpT2ZQZFlSZTVR?=
 =?utf-8?B?Yko4RTdlZ1lORDlMRDJvTUhURkV2TTI1aTIzZGUwUkMvVlZVU0J4Sm5TeUJt?=
 =?utf-8?B?RjUyU2QxelFpMkUyT3d5NFJ3VGo0U2sxTm1YblV6MW9Pc1hVVHdnTjhrNFJ0?=
 =?utf-8?B?Z2hKcEQxbHNtdHZ0citNTElGTVkxaFpsY2RTbzd2WWxUNWJWMVY4YnpTeDQz?=
 =?utf-8?B?eFVlSlhuOG81K013Y3dwcmtzRWpWekpBRFdHdEdzditjaWtORFZMZU5XQTh0?=
 =?utf-8?B?dWJ4dDBZRWJoVlR6NndhM3hoTzJCNmVXOTNxL1ZRS2F3b2x4VVoyQ3lKbXl0?=
 =?utf-8?B?eDMwS0V5MkdENXEzRHR2UDRWYnZCUnp2VFNaNVVGMC9nQkR5SG1pOW5qOWtQ?=
 =?utf-8?B?eUFvVVBtaXdnZjk2VFZlWkwwMjd4aFo2ZFNNOGFiR05BeFFLdStMTTYrQkVB?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1551FA4614E5F24EB5D65946D01C53F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cFROalZJeEVtbWhUWFZJZzB5VUVKNFFBbXlmcmdTU2VIQmkzalRTUUpSYzk2?=
 =?utf-8?B?KzYxSTZPdzFPcUNvK25iaDVqNUd5cXl0dE54WTNoMzNES2dlNkRyMjZkQU42?=
 =?utf-8?B?ajB2c0Nsdi9nMGFNeHdBaTdlVVhkamZWc3BxWjZyUEZJdHNQUlF4K1kxajUz?=
 =?utf-8?B?a2ZnMWFqYXFjaGtvejVXMUdoT0lacU5YelpWcjJ0K2pxa24zL3llcnNSL3hE?=
 =?utf-8?B?bDlYdDJtOGJRUm5qRmdJaVBiVWdLYnpET1BSRWl5V0h4UU52YkNoTW5aOUlv?=
 =?utf-8?B?L3NRQzFuRlkvTURKV3dVNVlicEYyQy9ZdWZOSmpmOEM0bHd0Z2FZTVBqQ2x1?=
 =?utf-8?B?UCt1ZmVzaW1YMCtGRFB0OENNQjd4NWxlU1lXc1FlUTA5bElwYlp6RDJxRWVT?=
 =?utf-8?B?cnMrNGM4V2NOdDZXdzFISDZZSytyVWoxREhWaHdWc0h6RHpacXM2WURlZlRM?=
 =?utf-8?B?TThYMC9ES0xCdmtMUGVianFTclh3TkpHZnZPNk1TaWI0VkdKOFhJVFJDczdv?=
 =?utf-8?B?bS93YytBOHBJTGJRMG1ubzhyMWFGR3hyNG5CWkhPOThoYmFnSE5kN00rdEQy?=
 =?utf-8?B?ZE9mNnZKRGd6VG0vNVZISWNHUWVBTjFsdVdKR1ZZaDJWUHY2aXNLYUliNjFl?=
 =?utf-8?B?SlI1YVI4bUJWRjR3QnI3b0JTVDdvYUlTakwvWHowOExtQ2hwQ1M4dFdpZVY0?=
 =?utf-8?B?VElVYWk5Sm45Nk55aWw0VG1FN3dFeDFmaHpNWDE2enhsYVl5eDlwQlQ0Q3V0?=
 =?utf-8?B?NFJucTZjSzNsVTV6VEdOQ3ZYcGozSkMwWXhBakQrRGdDdGVSa3MzTHVXYzJQ?=
 =?utf-8?B?NzVHQWFMaFp4eG5md295a2tDNW9KWFN5UU12b05nM3V4K0wwVkNuaWhUT1Bx?=
 =?utf-8?B?Z01oNENUWGx3K2NLZm9FbHc4SndqZWRHN3pWTjByU0NoMjZDNGJaeXRGdUdx?=
 =?utf-8?B?c3B2aTFwSUVlS3JzREVnUXVheDBsR2RSVkpYU0hpaWV1bTdIT1d5cGhpeWpt?=
 =?utf-8?B?NGR0TkovRkRCaDhoRHk1bXBvS0ZKWXpTSW5vS0E5cDc4MzJpazJnSVZKZzd5?=
 =?utf-8?B?Vkg0azA0YmZwVVFsczY5dTdrUCtQMEViWktKN1JMM2xheE9uU3NBZUpyVDRB?=
 =?utf-8?B?VjMvcTVYWEdvWFJHN3pXdDFFbzRvS0xrZWpQdm95VjVwNDA0V0szcHpHWnRn?=
 =?utf-8?B?dnBhd2psVi9YNE5LT3pFTENuVHJMSE1ubUpCa1FXVHpFcVo0OVU1dko5Z1Qz?=
 =?utf-8?B?N3lGSk9zdDBSOXg2b3BVY2w0U1E5ZkxxOVVUdHU5MXFMclRGZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff141d0e-adc4-4310-cca6-08dba048318e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 00:06:53.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIjclsHXWAN1cqKr7m2RCwEks/Wt45Iws8zL9aeYXw9yjDDeVpR5Sb9jWco6qJeJ/rm846vjyw8pdGAVIwpsSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Proofpoint-GUID: s9P5VtmutN0xbKzub4jEYcOevXaRUrNJ
X-Proofpoint-ORIG-GUID: s9P5VtmutN0xbKzub4jEYcOevXaRUrNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_28,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTgsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDE4
LCAyMDIzIGF0IDA3OjQ5OjI3UE0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBU
aHUsIEF1ZyAxNywgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgQXVnIDE4
LCAyMDIzIGF0IDAzOjEwOjQ4QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4g
SSB3YXMgcmVmZXJyaW5nIHRvIHRoZSBuZXh0IHJlcXVlc3QuIEl0IHNob3VsZCBub3QgYmUgcHJv
Y2Vzc2VkIHVudGlsDQo+ID4gPiA+IHRoZSBmaXJzdCByZXF1ZXN0IGlzIGNvbXBsZXRlZC4gRGVw
ZW5kaW5nIG9uIHRoZSB0eXBlIG9mIHJlcXVlc3QsIGlmDQo+ID4gPiA+IHRoZXJlJ3MgYSBkZWxh
eWVkX3N0YXR1cywgdGhlIGR3YzMgZHJpdmVyIHdpbGwgbm90IHByZXBhcmUgZm9yIHRoZQ0KPiA+
ID4gPiBTdGF0dXMgc3RhZ2UgYW5kIFNldHVwIHN0YWdlIChhZnRlciBzdGF0dXMgY29tcGxldGlv
bikgdG8gcHJvY2VlZCB0byB0aGUNCj4gPiA+ID4gX25leHRfIC0+c2V0dXAgY2FsbGJhY2suDQo+
ID4gPiA+IA0KPiA+ID4gPiBNeSB1bmRlcnN0YW5kaW5nIGZyb20gdGhlIGRlc2NyaWJlZCBwcm9i
bGVtIGlzIHRoYXQgc29tZWhvdyBkd2MzDQo+ID4gPiA+IHByb2Nlc3NlcyB0aGUgbmV4dCByZXF1
ZXN0IGltbWVkaWF0ZWx5IHdpdGhvdXQgd2FpdGluZyBmb3IgdGhlIHJhdw0KPiA+ID4gPiBnYWRn
ZXQgcHJlcGFyaW5nIHRoZSBkYXRhIHN0YWdlLg0KPiA+ID4gDQo+ID4gPiBVbS4gIFRoaXMgaXMg
b25lIG9mIHRoZSBkZXNpZ24gZmxhd3MgSSBtZW50aW9uZWQ6IGEgbmV3IFNFVFVQIHBhY2tldCAN
Cj4gPiA+IGFycml2aW5nIGJlZm9yZSB0aGUgb2xkIGNvbnRyb2wgdHJhbnNmZXIgaXMgZmluaXNo
ZWQuICBUaGUgVVNCIHNwZWMgDQo+ID4gPiByZXF1aXJlcyBkZXZpY2VzIHRvIGFjY2VwdCB0aGUg
bmV3IFNFVFVQIHBhY2tldCBhbmQgYWJvcnQgdGhlIG9sZCANCj4gPiA+IHRyYW5zZmVyLiAgU28g
aW4gdGhpcyBjYXNlLCBwcm9jZXNzaW5nIHRoZSBuZXh0IHJlcXVlc3QgaW1tZWRpYXRlbHkgaXMg
DQo+ID4gPiB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uDQo+ID4gDQo+ID4gTm8sIGFzIEkndmUgbWVu
dGlvbmVkLCBmcm9tIHRoZSBnYWRnZXQgZHJpdmVyLCBpdCBzaG91bGQgbm90IHNlZSB0aGUNCj4g
PiBuZXh0IC0+c2V0dXAgdW50aWwgdGhlIGZpcnN0IGNvbnRyb2wgdHJhbnNmZXIgY29tcGxldGlv
biwgcmVnYXJkbGVzcw0KPiA+IHdoZXRoZXIgdGhlIHRyYW5zZmVyIGNvbXBsZXRlZCB3aXRoIGVy
cm9yIGNvZGUgZHVlIHRvIGFib3J0IG9yIG5vdC4NCj4gPiBFdmVyeXRoaW5nIHNob3VsZCBoYXBw
ZW4gc2VxdWVudGlhbGx5IGZyb20gdGhlIGdhZGdldCBkcml2ZXIuIFRoaXMNCj4gPiBzaG91bGQg
YmUgaGFuZGxlZCBpbiB0aGUgZHdjMyBkcml2ZXIgKHRob3VnaCB3ZSBtaXNzZWQgYSBzZXR1cF9w
ZW5kaW5nDQo+ID4gc3RhdHVzIGNoZWNrIGluIHRoZSBkYXRhIHBoYXNlIHRoYXQgbmVlZHMgdG8g
YmUgZml4ZWQgbm93IHRoYXQgSSBsb29rIGF0DQo+ID4gaXQgYWdhaW4pLg0KPiANCj4gQWN0dWFs
bHkgSSBhZ3JlZSB3aXRoIHlvdS4gIFdoZW4gYSBuZXcgU0VUVVAgcGFja2V0IGFycml2ZXMgYmVm
b3JlIHRoZSANCj4gb2xkIGNvbnRyb2wgdHJhbnNmZXIgaGFzIGZpbmlzaGVkLCB0aGUgVURDIGRy
aXZlciBzaG91bGQgY2FuY2VsIGFsbCANCj4gcGVuZGluZyByZXF1ZXN0cyBhbmQgdGhlbiBpbnZv
a2UgdGhlIC0+c2V0dXAoKSBjYWxsYmFjay4gIChJIGRvbid0IHRoaW5rIA0KPiB0aGVyZSBpcyBh
IHN0YW5kYXJkIGVycm9yIGNvZGUgZm9yIHRoZSBjYW5jZWxsZWQgcmVxdWVzdHM7IG5ldDIyODAg
c2VlbXMgDQo+IHRvIHVzZSAtRVBST1RPIHdoZXJlYXMgZHVtbXktaGNkIHNlZW1zIHRvIHVzZSAt
RU9WRVJGTE9XLikNCg0KVGhvc2UgYXJlIHZlcnkgb2RkIGNob2ljZSBvZiBlcnJvciBjb2RlcyBm
b3IgY2FuY2VsbGVkIHJlcXVlc3QuIEV2ZW4NCnRob3VnaCB0aGUgZ2FkZ2V0IHNpZGUgZG9lc24n
dCBoYXZlIHZlcnkgZGVmaW5lZCBlcnJvciBjb2RlcywgSSB0cnkgdG8NCmZvbGxvdyB0aGUgZXF1
aXZhbGVudCBkb2MgZnJvbSB0aGUgaG9zdCBzaWRlDQooZHJpdmVyLWFwaS91c2IvZXJyb3ItY29k
ZXMucnN0KSwgd2hpY2ggaXMgLUVDT05OUkVTRVQuDQoNCldoZW5ldmVyIEkgc2VlIC1FUFJPVE8s
IEkgYXNzb2NpYXRlIHRoYXQgdG8gYSBzcGVjaWZpYyBob3N0IGVycm9yOg0KdHJhbnNhY3Rpb24g
ZXJyb3IuIEZvciAtRU9WRVJGTE9XLCBJIHRoaW5rIG9mIGJhYmJsZSBlcnJvcnMuDQoNCj4gDQo+
ID4gUGVyaGFwcyB0aGUgY29yZSBkZXNpZ24gc2hvdWxkIGJlIHNvIHRoYXQgdGhpcyBzeW5jaHJv
bml6YXRpb24gZG9lcyBub3QNCj4gPiBkZXBlbmQgb24gdGhlIHVkYyBkcml2ZXIgaW1wbGVtZW50
YXRpb24uDQo+IA0KPiBEbyB5b3UgbWVhbiB0aGUgVURDIGNvcmU/ICBJIGRvbid0IHNlZSBob3cg
aXQgY291bGQgZ2V0IGludm9sdmVkIGluIA0KPiBtYW5hZ2luZyBjb250cm9sIHRyYW5zZmVycy4N
Cg0KQWN0dWFsbHkgSSBkb24ndCBzZWUgaXQgZWl0aGVyLiA6KQ0KDQo+IA0KPiA+ID4gT25lIHF1
ZXN0aW9uIGlzIHdoeSBBbmRyZXkgaXMgb2JzZXJ2aW5nIGEgbmV3IC0+c2V0dXAoKSBjYWxsYmFj
ayANCj4gPiA+IGhhcHBlbmluZyBzbyBzb29uPyAgVGhlIGhvc3QgaXMgc3VwcG9zZWQgdG8gYWxs
b3cgYSBmYWlybHkgbG9uZyB0aW1lIGZvciANCj4gPiA+IHN0YW5kYXJkIGNvbnRyb2wgcmVxdWVz
dHMgdG8gY29tcGxldGUuICBJZiB0aGUgdXNlcnNwYWNlIGNvbXBvbmVudCBvZiANCj4gPiA+IHRo
ZSBSYXcgR2FkZ2V0IHRha2VzIHRvbyBsb25nIHRvIGFjdCwgdGhlIHRyYW5zZmVyIGNvdWxkIHRp
bWUgb3V0IGFuZCBiZSANCj4gPiA+IGNhbmNlbGxlZCBvbiB0aGUgaG9zdC4gIEJ1dCAidG9vIGxv
bmciIG1lYW5zIHNldmVyYWwgc2Vjb25kcyAtLSBpcyB0aGF0IA0KPiA+ID4gcmVhbGx5IHdoYXQn
cyBnb2luZyBvbiBoZXJlPw0KPiA+IA0KPiA+IEFzIEkgbm90ZWQgaW5pdGlhbGx5LCBpdCBzaG91
bGQgbm90IGhhcHBlbiBzbyBJJ20gbm90IHN1cmUgd2hhdCdzIHJlYWxseQ0KPiA+IHRoZSBwcm9i
bGVtIGhlcmUuIEdyYW50ZWQgdGhhdCB0aGUgc2V0dXBfcGVuZGluZyBjaGVjayBmb3IgZGF0YSBw
aGFzZSBpcw0KPiA+IG1pc3NpbmcgaW4gZHdjMyBkcml2ZXIsIHRoZXJlIHNob3VsZCBub3QgYmUg
YSBwcm9ibGVtIHVubGVzcyB0aGUgaG9zdA0KPiA+IGFjdHVhbGx5IGFib3J0ZWQgYSBjb250cm9s
IHRyYW5zZmVyLiBBbHNvLCB0aGVyZSBzaG91bGQgYmUgbm8gZGF0YSBwaGFzZQ0KPiA+IGZvciB3
bGVuZ3RoPTAgZXZlbiBmb3IgSU4gZGlyZWN0aW9uIGlmIHdlIGdvIHRocm91Z2ggdGhlIGNvbXBv
c2l0ZQ0KPiA+IGxheWVyLiBTbywgSSBkb3VidCB0aGF0J3Mgd2hhdCBoYXBwZW5pbmcgaGVyZS4N
Cj4gPiANCj4gPiBQZXJoYXBzIEFuZHJleSBjYW4gY2xhcmlmeS4NCj4gDQo+IE15IGltcHJlc3Np
b24gZnJvbSBoaXMgaW5pdGlhbCBlbWFpbCB3YXMgdGhhdCBzb21ldGhpbmcgZGlmZmVyZW50IHdh
cyANCj4gaGFwcGVuaW5nLiAgSXQgc291bmRlZCBsaWtlIGhpcyAtPnNldHVwKCkgY2FsbGJhY2sg
d2FzIGludm9rZWQgd2l0aCANCj4gd0xlbmd0aCA9IDAsIGJ1dCBiZWZvcmUgdGhlIFJhdyBHYWRn
ZXQgZHJpdmVyIHdhcyByZWFkeSB0byBxdWV1ZSBhIA0KPiByZXNwb25zZSByZXF1ZXN0LCB0aGUg
VURDIGRyaXZlciBzZW50IGFuIGF1dG9tYXRpYyBzdGF0dXMsIGF0IHdoaWNoIA0KPiBwb2ludCB0
aGUgaG9zdCBzZW50IGFub3RoZXIgU0VUVVAgcGFja2V0LiAgU28gdGhlIGdhZGdldCBkcml2ZXIg
Z290IHR3byANCj4gLT5zZXR1cCgpIGNhbGxiYWNrcyBpbiBhIHJvdyB3aXRoIG5vIGNoYW5jZSB0
byBkbyBhbnl0aGluZyBpbiBiZXR3ZWVuLg0KDQpXaGF0IGVsc2Ugc2hvdWxkIHRoZSBnYWRnZXQg
ZHJpdmVyIGRvPyBUaGVyZSdzIG5vIGRhdGEgc3RhZ2UgZm9yDQp3TGVuZ3RoPTAuDQoNCj4gDQo+
ID4gPiA+IEkgd2FzIHRhbGtpbmcgaW4gY29udGV4dCBvZiAwLWxlbmd0aCB0cmFuc2ZlciAoYWxi
ZWl0IEkgZm9yZ290IGFib3V0IHRoZQ0KPiA+ID4gPiBzcGVjaWFsIGNhc2Ugb2YgY29udHJvbCBP
VVQgZG9lc24ndCBoYXZlIDMtc3RhZ2UpLg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgaXQncyBhIHZl
bmRvciByZXF1ZXN0IDAtbGVuZ3RoIHRyYW5zZmVyLCB3aXRob3V0IHJlc3BvbmRpbmcgd2l0aA0K
PiA+ID4gPiBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVTLCB0aGUgZHdjMyB3aWxsIHByb2NlZWQg
d2l0aCBwcmVwYXJpbmcgdGhlDQo+ID4gPiA+IHN0YXR1cyBzdGFnZS4NCj4gPiA+IA0KPiA+ID4g
VGhpcyBtYXkgYmUgYSBob2xkb3ZlciBmcm9tIHRoZSBlYXJseSBkYXlzIG9mIHRoZSBHYWRnZXQg
c3Vic3lzdGVtLiAgTXkgDQo+ID4gPiBtZW1vcnkgZnJvbSBiYWNrIHRoZW4gaXNuJ3QgdmVyeSBn
b29kOyBJIHZhZ3VlbHkgcmVjYWxsIHRoYXQgdGhlIGZpcnN0IA0KPiA+ID4gVURDIGRyaXZlcnMg
d291bGQgcXVldWUgdGhlaXIgYXV0b21hdGljIFN0YXR1cy1zdGFnZSByZXF1ZXN0cyBpZiB3TGVu
Z3RoIA0KPiA+ID4gd2FzIDAgYW5kIC0+c2V0dXAoKSByZXR1cm5lZCAwICh3aGljaCB3b3VsZCBl
eHBsYWluIHdoeSANCj4gPiA+IFVTQl9HQURHRVRfREVMQVlFRF9TVEFUVVMgaGFkIHRvIGJlIGlu
dmVudGVkKS4gIFVubGVzcyBJJ20gY29tcGxldGVseSANCj4gPiA+IGNvbmZ1c2VkLCB0aGF0J3Mg
bm90IGhvdyBVREMgZHJpdmVycyBhcmUgc3VwcG9zZWQgdG8gYWN0IG5vdy4NCj4gDQo+IEkgZGlk
IGEgbGl0dGxlIGNoZWNraW5nLiAgVGhlIFVTQl9HQURHRVRfREVMQVlFRF9TVEFUVVMgbWVjaGFu
aXNtIHdhcyANCj4gaW50cm9kdWNlZCBmb3IgdXNlIGJ5IHRoZSBjb21wb3NpdGUgZnJhbWV3b3Jr
IC0tIG5vdCBpbiBvcmRlciB0byBtYWtlIGEgDQo+IFVEQyBkcml2ZXIgd29yayBwcm9wZXJseS4N
Cg0KSG0uLi4gcGVyaGFwcyB3ZSBjYW4gdXBkYXRlIHNvIHRoYXQgaXQncyBhcHBsaWNhYmxlIG91
dHNpZGUgb2YgdGhlDQpjb21wb3NpdGUgZnJhbWV3b3JrLiBDdXJyZW50bHkgZHdjMyB0cmVhdHMg
aXQgYXMgc3VjaCwgd2hpY2ggbWF5IG5vdA0Kd29yayBpZiB0aGUgZ2FkZ2V0IGRyaXZlciBkb2Vz
IG5vdCBrbm93IGFib3V0IFVTQl9HQURHRVRfREVMQVlFRF9TVEFUVVMuDQoNCj4gDQo+ID4gRm9y
IGR3YzMsIGl0J3MgYmVlbiBsaWtlIHRoaXMgc2luY2UgdGhlIGJlZ2lubmluZyB0aGF0IGl0IGF1
dG9tYXRpY2FsbHkNCj4gPiBxdWV1ZXMgdGhlIHN0YXR1cyB1cG9uIGhvc3QgcmVxdWVzdC4gVVNC
X0dBREdFVF9ERUxBWUVEX1NUQVRVUyB3YXMNCj4gPiBpbnRyb2R1Y2VkIHRvIHN1cHBvcnQgc2Nl
bmFyaW9zIHdoZXJlIHRoZSBkZXZpY2UgbWF5IG5lZWQgYSBsb25nZXIgdGltZQ0KPiA+IHRvIHBy
b2Nlc3MgdGhlIHNwZWNpZmljIHJlcXVlc3QgKHN1Y2ggYXMgU0VUX0NPTkZJR1VSQVRJT04pLg0K
PiANCj4gSXQncyBoYXJkIHRvIGJlIHN1cmUsIGJ1dCB0aGF0IG1heSBiZSB0aGUgY2F1c2Ugb2Yg
QW5kcmV5J3MgcHJvYmxlbS4gIEhlIA0KPiBtZW50aW9uZWQgc29tZXRoaW5nIGFib3V0IHRoZSBS
YXcgR2FkZ2V0J3MgLT5zZXR1cCgpIHJvdXRpbmUgcmV0dXJuaW5nIA0KPiBVU0JfR0FER0VUX0RF
TEFZRURfU1RBVFVTIHdoZW4gdGhlIHByb2JsZW0gb2NjdXJyZWQsIGJ1dCBJIHRoaW5rIGhlIA0K
PiBtZWFudCB0aGF0IGl0IGRpZCB0aGlzIGZvciB0aGUgc2Vjb25kIGNhbGxiYWNrLCBub3QgdGhl
IGZpcnN0IG9uZS4NCg0KSSB0aGluayBoZSB3YXMganVzdCBleHBlcmltZW50aW5nIHdpdGggVVNC
X0dBREdFVF9ERUxBWUVEX1NUQVRVUy4gVGhlDQpwcm9ibGVtIGhhcHBlbmVkIHdpdGhvdXQgdGhh
dC4gUmVnYXJkbGVzcywgd2UgbmVlZCBjbGFyaWZpY2F0aW9ucy4NCg0KPiANCj4gU3RpbGwsIEkg
cmVjb21tYW5kIHRoYXQgZHdjMyBub3QgYXV0b21hdGljYWxseSBxdWV1ZSBhIFN0YXR1cyByZXF1
ZXN0IA0KPiB3aGVuIHdMZW5ndGggaXMgMC4gIEdhZGdldCBkcml2ZXJzIGRvbid0IGV4cGVjdCBV
REMgZHJpdmVycyB0byBoYW5kbGUgDQo+IHRoaXMgZm9yIHRoZW0uICBGb3IgZXhhbXBsZSwgbG9v
ayBhdCB0aGUgY29tcG9zaXRlX3NldHVwKCkgZnVuY3Rpb24gaW4gDQo+IGNvbXBvc2l0ZS5jLiAg
SXQgZG9lcyB0aGlzOg0KPiANCj4gCS8qIHJlc3BvbmQgd2l0aCBkYXRhIHRyYW5zZmVyIGJlZm9y
ZSBzdGF0dXMgcGhhc2U/ICovDQo+IAlpZiAodmFsdWUgPj0gMCAmJiB2YWx1ZSAhPSBVU0JfR0FE
R0VUX0RFTEFZRURfU1RBVFVTKSB7DQo+IAkJcmVxLT5sZW5ndGggPSB2YWx1ZTsNCj4gCQlyZXEt
PmNvbnRleHQgPSBjZGV2Ow0KPiAJCXJlcS0+emVybyA9IHZhbHVlIDwgd19sZW5ndGg7DQo+IAkJ
dmFsdWUgPSBjb21wb3NpdGVfZXAwX3F1ZXVlKGNkZXYsIHJlcSwgR0ZQX0FUT01JQyk7DQo+IA0K
PiBDbGVhcmx5IGl0IGRvZXNuJ3Qgd2FudCB0aGUgVURDIGRyaXZlciB0byBxdWV1ZSBhIHJlcXVl
c3QgZm9yIGl0LCBubyANCj4gbWF0dGVyIHdoYXQgd0xlbmd0aCBvciB2YWx1ZSBpcyBzZXQgdG8u
DQo+IA0KDQpkd2MzIHBhcnNlIHRoZSBTRVRVUCBkYXRhIGFuZCBkZXRlcm1pbmUgd2hldGhlciBp
dCdzIGEgMy1zdGF0ZSBvcg0KMi1zdGFnZSBjb250cm9sIHRyYW5zZmVyLiBJZiB3TGVuZ3RoID4g
MCwgdGhlbiBpdCBtdXN0IGJlIGEgMy1zdGFnZQ0KY29udHJvbCB0cmFuc2Zlci4gVGhlIGR3YzMg
ZHJpdmVyIHdvdWxkIG5vdCBxdWV1ZSB0aGUgc3RhdHVzIGltbWVkaWF0ZWx5DQp1bnRpbCB0aGUg
ZGF0YSBzdGFnZSBpcyBjb21wbGV0ZWQuDQoNClRvIGVuZm9yY2UgdGhlIGdhZGdldCBkcml2ZXIg
dG8gbWFudWFsbHkgcXVldWUgdGhlIHN0YXR1cyB3b3VsZCB0YWtlDQpzb21lIGVmZm9ydCB0byBl
bnN1cmUgYWxsIHRoZSBVREMgZHJpdmVyIGNvbXBseSB0byBpdC4gV2Ugd291bGQgYWxzbw0KbmVl
ZCB0byB1cGRhdGUgdGhlIGNvbXBvc2l0ZSBmcmFtZXdvcmsuDQoNCkJSLA0KVGhpbmg=
