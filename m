Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8E7C75BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441914AbjJLSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbjJLSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:19:17 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AEA9;
        Thu, 12 Oct 2023 11:19:15 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHGdIN029560;
        Thu, 12 Oct 2023 11:17:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=t0V6FlernsD63YLO3i/DPZK6Fwh8riD+Yiipd8abbvE=;
 b=Sv4bzQ3hzYDPEOET4N7Ur7pW/KDXcmOsCwNOO2dk2UQ3bFSYY2kqr+6lnhRMZ2pzcUmj
 NRpjz7z0L/X5JDAko3X+nSInnnMaaF5RzdSO2B5rjM2dlLCMwo+q5zNG8gb8BIk8zJo2
 ATC04f4zbLCJALX7qcC+YrBKSBOkIV/x4iPPj1dlvYEcL0BFmd/icjP+GWVgI7NZ5VKm
 Wk9HxzqrYvWfFE1IdCekTWMTH0/3XIaa6XxUxi9Pa99OfFZhHvKjG6j0v3M7WRA7aP2i
 CAa5DKwcsRH9SttSrgRaYaM4R/7Ci9tlh0jab4vr1EqYZyfwQRAJFSG1FIFPi/vYMWWd Hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tkh0pjrgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:17:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697134671; bh=t0V6FlernsD63YLO3i/DPZK6Fwh8riD+Yiipd8abbvE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cj0sida4HG15t/IG/0ab2FyDuy8fVRSPLSPHUfN5TD3EBWQ+92N8qKe3sXZ4Y/pKl
         RKAD1YVHpfrEclPWXXTzDFebjeyXTZog305GtOy/9bgv3/CxjI7609x15i3xBqLZCk
         BjNhtvuN1Jh9bDGgunrfaeZEprCiC7LaY6wraKRCmeRX+o0V82XIkUlCmtriGCQuHJ
         gpHnliWvW84cSmaFfLXfmP86AT24qf7G0eGdfL63WhfYMMTaGjegnkhX0d8INH+Bxx
         KR3FxMbjvXBUpd6cUMV6UZ+PQ6XsiM1SONqGd1HYEvFRtSnHtVLvfUimNNEeF/QgJ/
         vIeYBhi01SUbQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3371640493;
        Thu, 12 Oct 2023 18:17:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7156CA006D;
        Thu, 12 Oct 2023 18:17:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qnginn7F;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B0D514013C;
        Thu, 12 Oct 2023 18:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWoFTBE9na2nUqZLRHmBKcnFRPtuQnLOipVQ6YSTal0s8qGg+it1lpXUmcCQI39YAmdV9ooR9slp1RAMOfksk73Kbc9bAQxRSao2ulX8XscQwAGcbJQfRd3rMkBcIYq5fD4DwLZkuo0BjOTXNrAoAD/y7rKHFsuwa0AMMmdOEX+dl/oPVnRkQ1+8bUJIplc1jPj5UgDkA7D9xejkAhyriLtxWjutCndDWQ+L/1wYtT3PAyb+uZASbCh1zHobAFepMEIM+AO5/mHxH9NTDySjA6XVE5L9YTOfdpU6fU72gWC9qP+QSIPjkO0e9I2rnq2aKuwtiBAhd0aaE0X3uHxfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0V6FlernsD63YLO3i/DPZK6Fwh8riD+Yiipd8abbvE=;
 b=TqKdQUZruB4bb/S/CeLfIrsZRMqtTCFjHEBCbn1uLw+PPW/iu/wnA6qZ7OeW0IypMXeValiSs79Id2ue4CDIovERPd7aTa5niEWqkGGWG6vJbkdMZbKyCg3mYmdq2yTFIV4kVWU5ln3oi/8UHQD4ZYjZ8kz3BzC7xQ7rZSe63mALo4qUKZbFc36V4IZ12GuTwSXU9zGXxykEBfNFlDyk9fJ7QQlyzL2YCl1b4MRVCudNueyEoCUGXrpXPOipvjJMgHlhOuOTJy2GP4mlYw4as2XGP8a07DZ1UbsIKsWfxSzTZwzp1PCBTF6idbivcjNsOnCfaYp+jxbK9K3uaL7QZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0V6FlernsD63YLO3i/DPZK6Fwh8riD+Yiipd8abbvE=;
 b=qnginn7FSeUx3L9+LpNTqdrBMRiHMUsPQK44qTavjFHf/fKG0G0PmWl1HHHNH+x2mrUSAYUXDyRMWC4dDiG6ZYN6hCrShysoLf7ew7Z4fOd7vUY1b65mTuHh10bx/RZpZwoazJvjMKXvCM6MIDUQhwb/A9iqYJyi8LddNikPgFs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:17:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:17:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "bgoswami@quicinc.com" <bgoswami@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 16/34] usb: dwc3: Specify maximum number of XHCI
 interrupters
Thread-Topic: [PATCH v8 16/34] usb: dwc3: Specify maximum number of XHCI
 interrupters
Thread-Index: AQHZ+9kiglcm2Ql1R0qDZyO0vQGm8rBGeQQA
Date:   Thu, 12 Oct 2023 18:17:41 +0000
Message-ID: <20231012181728.gydszr5nu2c6r3a5@synopsys.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
 <20231011002146.1821-17-quic_wcheng@quicinc.com>
In-Reply-To: <20231011002146.1821-17-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5295:EE_
x-ms-office365-filtering-correlation-id: 102856d8-ae3f-4057-ad35-08dbcb4f860a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eh7+TQ8gDa1ArMXy87DIsS2oX8WvHBaSuH4S+KmeOR9PD3QfH5ozmoIHhn+qr0UlAHaVw2tGi7z+W2/eJ+QfFiDhWXJFnnLBHuTrLpF4EB6HJodNHx4YcRiXk13y6EOqq6WjE7mwpP9bM6C6Kd/6J5tjgWEus6pcs1i+E+IzhVjZEkELlqKlaRuCkjl4mTIc2Cnevytf9hqICjSrBceeDhHTwt+ZH9KaxO/elXbJTr0ySoiEx1vXWN5Qpum5+6Wqhu0BL07EAqQ4r9Mjln32bKTgtGKk8OL39+nFoGz0lWjAGlJKf384McaJWb86jLrOuA1oTDtzopjJQavVsWtl4jZaM20PktcCEeqb3H26YuTeKDxftPNvMrYo7fcgTnD4wc8tiLuqg9s3u+yDOnZ/P8DKCF3ofGRCW39lYgKuaZVwqsepVyYl1YvACB6eFdJIwz2FfPFfVOKLVq9pP/ZwX5/Y3fTZp2sc8yPIC9x1azIlWYJr21OrCglhsc22s05+vcqcWpK0aLald8vbWqqW31X0FQKcRoKDia9BnbsXcYgLnMrjfdLoXMrmxYtPEteGZgL8UIevLSM4ZSSqIPJd6cxaGQ7qWmgVlsfK8yO5lmP+pgarsrwkU35i1wiW8GmW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(71200400001)(2906002)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(54906003)(316002)(6916009)(36756003)(83380400001)(26005)(6506007)(6512007)(2616005)(122000001)(86362001)(38070700005)(38100700002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmFEVmtOKzRrOUw5aHFoTmlEYWczdDEzNVA1VEg0T2szQUVhMXZQaG9wdXdt?=
 =?utf-8?B?eUpGUktRZk5ZbWo4Mkl1SEJHdGVucThqdUxCTGRXVkEwemdKbzRwNHRQSi9X?=
 =?utf-8?B?NFV2SlAwVkV4VEFJL0lGRm81TlVRaThuQjJBTGtyMms1bFBoYis0YUdEWWUw?=
 =?utf-8?B?UUplMzk1SmpPc1NkblRJNDk4T3NkMHhObmk1eXJsTXdNRnpCVU1sRnp4L2do?=
 =?utf-8?B?eWg3WGNyQUxyZE9tVkpKUktVVjU2aFBtOXhaK1EyZERPcHdScEVWR1dweFpI?=
 =?utf-8?B?aGt2WW9qZGRVUGMrOVFaODhnQ0U1K0pKZCtDNG5MSVZrSDJxT3ArVmczUkFK?=
 =?utf-8?B?NXdYaFBaWmp1dVR2OG5MVjBSVlJybTAwU3VVVzVRSG94eDRJd1ZJc1FpRFA5?=
 =?utf-8?B?WXpwSzJ0VmpmWWQyTlZWelNVOVJuK0FDV0JId2FSbS9YUzRwQXNjckhHZWpp?=
 =?utf-8?B?SjFqNWJQSVZ6SDhwV2NYNVZHUXFqajdPS0pseTFkeThqaURoVzNTblJ0NEZG?=
 =?utf-8?B?czRBbFg5bzJMM0Vhb0Rzb3ZIa3dnMGU0dllSTWs1ZWxZb2ZHUzFGN3k3a3JM?=
 =?utf-8?B?UjJBdkI0L3FrUEhER3djdXdFR0hmWFRDMExJMHRxZHZiOWFUdVowOEh1Qm5M?=
 =?utf-8?B?a1lpU21XdmFSUzNBTFc4Zjd1NWk1aFBneC9KVkFWL3VRenRQeWZ2amt5RjNw?=
 =?utf-8?B?WkJhRWVzZEtpa0ZIY2pCSHZwVVJzRGxsTWdHMWlwbVNsd2tpaG9veTBIQkRn?=
 =?utf-8?B?cHBEOXlGeXBSVDNlUkJqQXFJc0oyWk9Va1c1NHlHdVU4K2FOSGdhVmdSV3Fo?=
 =?utf-8?B?ZTFnWlhvOXZOMUw0VUtSZlBGK0VuL1ZUeGczZWljSzg2VXBVZHVrb0lRZC9r?=
 =?utf-8?B?eUZYZ09vSGNXTFJJWE5oR1lGbFNvdFRodGQ5QWNtM3V3WWkvMi9LejBWVFd3?=
 =?utf-8?B?RjRXRzE3RzU2aWFPWVhNT0FSTmhjU09nb3IrbjhkNFprRjlIRnYyV2dLb2tx?=
 =?utf-8?B?ckRBMHdRVWIvZ0VoeW5JcmwvRWh4ZDlBcU9TbWV0Q0xUdjl4aGxhWitGRHcw?=
 =?utf-8?B?b002OEUySkJUa0doOWl2alUza2dlaEVpOFUzN3gxZzdMa2dCcXBWZ2E3TUNZ?=
 =?utf-8?B?VzJiemkycTE5azdNQUNRcWE4Qk5XRFh5cTUrTFJISlgrL3Vhd1ZPL1lXMkVN?=
 =?utf-8?B?SzRYbHUrRmFvZDBoVVNFeGtXeWUzcWxVY2h5S0ZQWEc4NXU0SWpBZ0VzZnBm?=
 =?utf-8?B?Q2xUbGtxeUJiaktYMGR2amlFS2hXcTBQY2d4bDBDTWFxeU1OSTFNYlVLaFd1?=
 =?utf-8?B?VUN4OFRieTVHVWNGL1NiT1UyYVJ2cGdFQ1JXVnJ2ZDZsem9iNlhVdFowYVVX?=
 =?utf-8?B?anVzckw0Q0pYTE9DTjRZbGdnZ1dqcGY3RmViMGptSDlGK2FwK2Zrb280STR4?=
 =?utf-8?B?Vk9mTERQVmFZZldBQWRlV0c4NDZndmRISDhlU004VWlxTG9VZWhlMnZvZ3pQ?=
 =?utf-8?B?bU1SdjNmY3NHRFhUQ3dKaGNPSDZrRnlybS9LN1hrT3Zxcm1hOHM0RjRDaEtO?=
 =?utf-8?B?R3IxUWV4bVplMG5CQ2JHYWFkbEZhN3NkQzVZby9uaVZYMFZkM0N6TzRwMmVK?=
 =?utf-8?B?WjI0amp1TnU2ZHB5Zmo1M1M3TDlEZnoxdE5JVXhoNHRrZlRlZWhtWWtDd1lO?=
 =?utf-8?B?aGFrcWJiRU9hTjRnSW5Ic01yK1VJOGRtZm9NVXZwRHd1eVZRd2toZ2hNVWpp?=
 =?utf-8?B?NWJXd2EyMk4zTE1oYVFJNm4wVHVVVmMzQm16UHBmM1c4ZGJwSnFlZHVmdnQ0?=
 =?utf-8?B?WDdGVTRYTFh6NDhrMCs4K3FUUjh0Qk1EUmZUVlF1dzhDMGt4eHR2RWJBLzlV?=
 =?utf-8?B?VGtZelpXOUc2Wm5NampFQklMZjRTcFVsL09YbnJ2Z1p6SlE5cnUzNUlndTBD?=
 =?utf-8?B?L3dueHo0eXVaT281eEtha3FvWVdZd3Zja2UxeWxnenBUZlIwMk5LSjVhWmdx?=
 =?utf-8?B?c1IrVXFKOXg0b1NKNHpsMFBxdVlBV08zcDR6WUN6enU1NjQra0o2R2ZYODc2?=
 =?utf-8?B?ZXpGV2VKNUdzL3J6TUI1RzFyRlJWV3lKVXRIbXk2M0IwQmNKYllJNUtSd3JQ?=
 =?utf-8?B?YVhZS0VSMUY0VklKU2FYQnVuN0Q5MlQ2SXZDb1J2bEdkTGdnanpWc2Z2bHNp?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29E899DD617B504DA32A3A5E698DBDCA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RDh5bUMzMllIYkIzNkhJbnVIUkxrTllxcmVsNyt1SjFWMFRPY1BKczVOZURn?=
 =?utf-8?B?VXZub3FaUG9WWUNEV1RRRWFrUEY2cHR1WUZKcTMyVC9peldjTm1MeGc5WWxo?=
 =?utf-8?B?cUsxLzJtVjQ5U3hkYjU1NGFnZ21KQXJ1cmpDbG1OQnQ2Zjd2NktnMGQ2a2pY?=
 =?utf-8?B?WU1oS1F0TENydHNYTTE0RE9nYTdMVWM2aTZ5THFHMHUrakxxWjRCdHlGdFVi?=
 =?utf-8?B?TkN3WHdGRGRZdWZzR3VHem9IMGpOQzdFYTF0ZzJXT3l4VE5oN3NsMzd4RGcz?=
 =?utf-8?B?V2dQZnkrcklNMTBpdFA4M0VraW9xTzFicmZJay91MmtINEpCaWlRZW1oNUdt?=
 =?utf-8?B?WUJ4MlRHc01qN0tHWUp1OE9yZ2orQVppNXJBMVh4REV5Q2M5SVNZdWpkVEt0?=
 =?utf-8?B?UGo1MjBhYU5odjFTbWpiemhtaEtwRzBLQWVXTUU1ajZMeVVIdStLWnNtT0Ro?=
 =?utf-8?B?Y2VROExmLyt2R2hkUWpkVEN1V1NjQVQ3NW4yRHVMaVhoN2g3RmExU2tseTFK?=
 =?utf-8?B?aXFObC9tM1l5M0Nxb1FJQ0tQVUlPY1F6VXpRUUVBN0R0dnVyWjg0dk9FOG5x?=
 =?utf-8?B?T1ZDdUJSb3FTV0c2NDdTaXI2WW5qcW1yTy9HTjdpYXdjQ2FmUlVPOE5ZdEMy?=
 =?utf-8?B?WjY2cVJRaDNQSWRvVjJMbk9mU1pITGZicjhodzdOVWlFWkY2K21qaFpob0dk?=
 =?utf-8?B?RUh1cUFKcmpJd21GeTVvTDdOS04xQjYrTlBQMVN4MFBJbFZuY1FwL2NuVlc5?=
 =?utf-8?B?QjF6b1o0bGtwallZblYxMWhjNEcwaE04cGlRL0JtWmdxTSsvZWhia0pBRVMy?=
 =?utf-8?B?aWd2eTJkWHIyQU5LVWNJd3ZnSXFSemhtNjY4T3ZHTXJXZDdBY21qN1hjS0pD?=
 =?utf-8?B?U1p0c0xabEFHemFVZlltUVRBUUlPekJFWDZiK3FBVm10d2xReS9VeStvZXdQ?=
 =?utf-8?B?d0tUR25YRmRlSHEvR2xaZVcrdU5adExJTk9OaVlYU0NFMSs4TXVBTFh1SDNT?=
 =?utf-8?B?d0p5cnJ6QmZqSHZpcTU2elFWbExhMExtMlZiVmxVVnhQU3N3S1dOWVdJR2Y2?=
 =?utf-8?B?US9ZcFhjaVVOVTZsaSt4bjFxbTMySWFCS3FhcWgxY0grbFFkRHlHM0VOQ0la?=
 =?utf-8?B?Vmc5M0hMVFFhNElvdVRMTm9RUzhtbFpmVWlaYXBGY3MwQjFWQ1FCek1lbmsy?=
 =?utf-8?B?TXNadWNGdTdsSkFjWlBIRDhoWlBDV0ZtaW9jYlJTbFVyRXFmeEQ5S21PNmVE?=
 =?utf-8?B?SUF4TjdCb243Qk4vdDI2dUFnd1JFZ3V1b1pYMHNrRTh0Z29kN3pxVHBLcnVL?=
 =?utf-8?B?d3o1ZVVqVkRoRTk1QUU5WEJBRStwSE81NjZEQnMzMnN5VHgvd1YrVFVsYnZ0?=
 =?utf-8?B?TWlGSnQ2U09iLzF3dnVqWmtXRzUrd0pWMTZDSVNFM2FnbjRkTW1qdDBEV0Y1?=
 =?utf-8?B?Vkc3aTMvMVl5cnRVejVYVjBUdWtlem5wMXIxSkhnPT0=?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102856d8-ae3f-4057-ad35-08dbcb4f860a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 18:17:41.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EITggj4lcN0e00GadwZsAM1WznXW6XpWirab1V3KwCuAesxl4npKisbMJ80ocnsl/mgU33mdHmgumZbfUKgNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
X-Proofpoint-ORIG-GUID: z8l09zG0ukLxMw-uqb-5jpT_YLf-EjGt
X-Proofpoint-GUID: z8l09zG0ukLxMw-uqb-5jpT_YLf-EjGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=847
 lowpriorityscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTAsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gQWxsb3cgZm9yIHRo
ZSBEV0MzIGhvc3QgZHJpdmVyIHRvIHBhc3MgYWxvbmcgWEhDSSBwcm9wZXJ0eSB0aGF0IGRlZmlu
ZXMNCj4gaG93IG1hbnkgaW50ZXJydXB0ZXJzIHRvIGFsbG9jYXRlLiAgVGhpcyBpcyBpbiByZWxh
dGlvbiBmb3IgdGhlIG51bWJlciBvZg0KPiBldmVudCByaW5ncyB0aGF0IGNhbiBiZSBwb3RlbnRp
YWxseSB1c2VkIGJ5IG90aGVyIHByb2Nlc3NvcnMgd2l0aGluIHRoZQ0KPiBzeXN0ZW0uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTIgKysrKysrKysrKysrDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAyICsrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2hvc3Qu
YyB8ICA1ICsrKystDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDQ0ZWU4NTI2ZGMyOC4uNjUyMTcxYzJmMjQ0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTQ1OSw2ICsxNDU5LDcgQEAgc3RhdGljIHZvaWQgZHdj
M19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXU4CQkJdHhfdGhyX251bV9w
a3RfcHJkID0gMDsNCj4gIAl1OAkJCXR4X21heF9idXJzdF9wcmQgPSAwOw0KPiAgCXU4CQkJdHhf
Zmlmb19yZXNpemVfbWF4X251bTsNCj4gKwl1MTYJCQludW1faGNfaW50ZXJydXB0ZXJzOw0KPiAg
CWNvbnN0IGNoYXIJCSp1c2JfcHN5X25hbWU7DQo+ICAJaW50CQkJcmV0Ow0KPiAgDQo+IEBAIC0x
NDgxLDYgKzE0ODIsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJICovDQo+ICAJdHhfZmlmb19yZXNpemVfbWF4X251bSA9IDY7DQo+ICAN
Cj4gKwkvKiBkZWZhdWx0IHRvIGEgc2luZ2xlIFhIQ0kgaW50ZXJydXB0ZXIgKi8NCj4gKwludW1f
aGNfaW50ZXJydXB0ZXJzID0gMTsNCj4gKw0KPiAgCWR3Yy0+bWF4aW11bV9zcGVlZCA9IHVzYl9n
ZXRfbWF4aW11bV9zcGVlZChkZXYpOw0KPiAgCWR3Yy0+bWF4X3NzcF9yYXRlID0gdXNiX2dldF9t
YXhpbXVtX3NzcF9yYXRlKGRldik7DQo+ICAJZHdjLT5kcl9tb2RlID0gdXNiX2dldF9kcl9tb2Rl
KGRldik7DQo+IEBAIC0xNTMyLDYgKzE1MzYsMTIgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJv
cGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQkJCSZ0eF90aHJfbnVtX3BrdF9wcmQpOw0K
PiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4KGRldiwgInNucHMsdHgtbWF4LWJ1cnN0LXByZCIs
DQo+ICAJCQkJJnR4X21heF9idXJzdF9wcmQpOw0KPiArCWRldmljZV9wcm9wZXJ0eV9yZWFkX3Ux
NihkZXYsICJudW0taGMtaW50ZXJydXB0ZXJzIiwNCj4gKwkJCQkmbnVtX2hjX2ludGVycnVwdGVy
cyk7DQo+ICsJLyogRFdDMyBjb3JlIGFsbG93ZWQgdG8gaGF2ZSBhIG1heCBvZiA4IGludGVycnVw
dGVycyAqLw0KPiArCWlmIChudW1faGNfaW50ZXJydXB0ZXJzID4gOCkNCj4gKwkJbnVtX2hjX2lu
dGVycnVwdGVycyA9IDg7DQo+ICsNCj4gIAlkd2MtPmRvX2ZpZm9fcmVzaXplID0gZGV2aWNlX3By
b3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJCQkJInR4LWZpZm8tcmVzaXplIik7DQo+ICAJ
aWYgKGR3Yy0+ZG9fZmlmb19yZXNpemUpDQo+IEBAIC0xNjIwLDYgKzE2MzAsOCBAQCBzdGF0aWMg
dm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjLT5pbW9k
X2ludGVydmFsID0gMDsNCj4gIA0KPiAgCWR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bSA9IHR4
X2ZpZm9fcmVzaXplX21heF9udW07DQo+ICsNCj4gKwlkd2MtPm51bV9oY19pbnRlcnJ1cHRlcnMg
PSBudW1faGNfaW50ZXJydXB0ZXJzOw0KPiAgfQ0KPiAgDQo+ICAvKiBjaGVjayB3aGV0aGVyIHRo
ZSBjb3JlIHN1cHBvcnRzIElNT0QgKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggYzZjODdhY2JkMzc2Li4y
Y2U1ZTFlNTkzODAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0xMDYwLDYgKzEwNjAsNyBAQCBzdHJ1
Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqIEB0eF9tYXhfYnVyc3RfcHJkOiBtYXgg
cGVyaW9kaWMgRVNTIHRyYW5zbWl0IGJ1cnN0IHNpemUNCj4gICAqIEB0eF9maWZvX3Jlc2l6ZV9t
YXhfbnVtOiBtYXggbnVtYmVyIG9mIGZpZm9zIGFsbG9jYXRlZCBkdXJpbmcgdHhmaWZvIHJlc2l6
ZQ0KPiAgICogQGNsZWFyX3N0YWxsX3Byb3RvY29sOiBlbmRwb2ludCBudW1iZXIgdGhhdCByZXF1
aXJlcyBhIGRlbGF5ZWQgc3RhdHVzIHBoYXNlDQo+ICsgKiBAbnVtX2hjX2ludGVycnVwdGVyczog
bnVtYmVyIG9mIGhvc3QgY29udHJvbGxlciBpbnRlcnJ1cHRlcnMNCj4gICAqIEBoc3BoeV9pbnRl
cmZhY2U6ICJ1dG1pIiBvciAidWxwaSINCj4gICAqIEBjb25uZWN0ZWQ6IHRydWUgd2hlbiB3ZSdy
ZSBjb25uZWN0ZWQgdG8gYSBob3N0LCBmYWxzZSBvdGhlcndpc2UNCj4gICAqIEBzb2Z0Y29ubmVj
dDogdHJ1ZSB3aGVuIGdhZGdldCBjb25uZWN0IGlzIGNhbGxlZCwgZmFsc2Ugd2hlbiBkaXNjb25u
ZWN0IHJ1bnMNCj4gQEAgLTEyOTQsNiArMTI5NSw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gIAl1OAkJ
CXR4X21heF9idXJzdF9wcmQ7DQo+ICAJdTgJCQl0eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiAg
CXU4CQkJY2xlYXJfc3RhbGxfcHJvdG9jb2w7DQo+ICsJdTE2CQkJbnVtX2hjX2ludGVycnVwdGVy
czsNCj4gIA0KPiAgCWNvbnN0IGNoYXIJCSpoc3BoeV9pbnRlcmZhY2U7DQo+ICANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMN
Cj4gaW5kZXggNjFmNTdmZTViYjc4Li43OWNlMzU5YzM0MmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+IEBA
IC02MSw3ICs2MSw3IEBAIHN0YXRpYyBpbnQgZHdjM19ob3N0X2dldF9pcnEoc3RydWN0IGR3YzMg
KmR3YykNCj4gIA0KPiAgaW50IGR3YzNfaG9zdF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7
DQo+IC0Jc3RydWN0IHByb3BlcnR5X2VudHJ5CXByb3BzWzRdOw0KPiArCXN0cnVjdCBwcm9wZXJ0
eV9lbnRyeQlwcm9wc1s1XTsNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlCSp4aGNpOw0KPiAg
CWludAkJCXJldCwgaXJxOw0KPiAgCWludAkJCXByb3BfaWR4ID0gMDsNCj4gQEAgLTEwNyw2ICsx
MDcsOSBAQCBpbnQgZHdjM19ob3N0X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlpZiAoRFdD
M19WRVJfSVNfV0lUSElOKERXQzMsIEFOWSwgMzAwQSkpDQo+ICAJCXByb3BzW3Byb3BfaWR4Kytd
ID0gUFJPUEVSVFlfRU5UUllfQk9PTCgicXVpcmstYnJva2VuLXBvcnQtcGVkIik7DQo+ICANCj4g
Kwlwcm9wc1twcm9wX2lkeCsrXSA9IFBST1BFUlRZX0VOVFJZX1UxNigibnVtLWhjLWludGVycnVw
dGVycyIsDQo+ICsJCQkJCQlkd2MtPm51bV9oY19pbnRlcnJ1cHRlcnMpOw0KPiArDQo+ICAJaWYg
KHByb3BfaWR4KSB7DQo+ICAJCXJldCA9IGRldmljZV9jcmVhdGVfbWFuYWdlZF9zb2Z0d2FyZV9u
b2RlKCZ4aGNpLT5kZXYsIHByb3BzLCBOVUxMKTsNCj4gIAkJaWYgKHJldCkgew0KDQpBY2tlZC1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpU
aGluaA==
