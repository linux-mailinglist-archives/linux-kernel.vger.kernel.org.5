Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC63B78D1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbjH3BiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjH3BiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:38:03 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A910C9C;
        Tue, 29 Aug 2023 18:38:00 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TMQGf1014741;
        Tue, 29 Aug 2023 18:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=eHq2dSBhGbgL+Rn1bZeZQ57Pv7JaGF0llIMsByxrs3o=;
 b=s477x4NfkbfDW1tIxiDuXcJRVU1um2fbq5K72kqn9jXZVJyN+POR5usHi7q0JE71HHlM
 vdGTqbb22LKb1kOrTcEQ+EUZ9Lv48VwIOGkawsE6RiU0GfbOJqH9ek2WEPlz7LoQgPtf
 sa0VOo1u55l/bWj3TeDwB/lkusJ0urYi9nUvviFYZjkZ5a65YNaWRy7Z4JrBdynAr5uT
 SNl0CNcWUKpNG3hvAWOJxAWNHSmqxqzyAIcoif64WiOMll3fMq7ue2Th9rbNvBN4n0KC
 ieSrCjkX6mkceZFFU+ELOhQNLi+RRdIzpc1mtQALWqIdSoR50Lj3Ozbks5UWMCu6p4Oi dQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3sqg1e0fm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693359466; bh=eHq2dSBhGbgL+Rn1bZeZQ57Pv7JaGF0llIMsByxrs3o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=atXTogCQDJRnbo4MH66pPWyuOrJnVtKOPATtq2TCaFNMUkHyt1htnF/d+tutsA/t6
         PQTy77acUHRw6n5JUWeYenZWxMYs4UCkTtpHwwvmf///AVYh+3yxPuihTUOo1OeMel
         C2LkbmAJqWv3n2wFiUqOzjFSvPYrNSFOHrec6S/MmaOVHcyWZlqvMdbiUqAqvE+XZE
         qAj5E7O6NFCJWI7Q1apIL4JsU1aC+qLfSrZV1dp0RmOvkp8TO+DNNmA9q0UjdPVDdR
         ig06aWZS3SwjC1jL9YIxe54gbrSwtyFnfNF/s04vtFymshLmRu3Eg0bL9OUEh0Ay3g
         wMRHY+t94iNbg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9DAC6401CF;
        Wed, 30 Aug 2023 01:37:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1E311A007B;
        Wed, 30 Aug 2023 01:37:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=d605V4vd;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 69A1C404AC;
        Wed, 30 Aug 2023 01:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQWvyRSqczmET88fBsDv3WzuSJPsnG1J2OWWFrefandtDYrKPTcI6RVKA4o+u1KZMLqKt3oFhzUMZf4W8Ghnt4OePaUkhEY4hRA64xbuYvQ0CQe1xPjIC118a+lHwj3sIaM0dlUe0lg2fsSW4tyvFd3+YYW3gos4PL9uOQkENFQ5zgM6Pc9YR9w6omDsyDir1CC/BSBckogdGDokedsbgE19HJcgeG5e2oiqWDYw0PVFwRQ7o53ZrLfm8n2xWGZqzqhTLqOmMZCHb+hWg1KXb/vyYzITfn8+s+xrYoCoAR1fk0tPdxR6qVk/iCSKap7VOrBYVOr/xOY0cS8gX3rJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHq2dSBhGbgL+Rn1bZeZQ57Pv7JaGF0llIMsByxrs3o=;
 b=A3KU5vDn2djc5+nJtWgJEmKhWprbSGYBPNJF5ObXl9BdsDYBnn864xQjfo7wcBUpou4w8Og2Sa6KL8C6wrz4xCl+J7X+Okr3S9pPUSCYTPU5+7ZlmL0OrgtC0c7AmlF96uOCUTQw/PiDC7L4BiJYC7bUnD7y5W7Mlu8je+MP5frPiZywvsFTRGSBZE8NgY8pFKCrGURoQ/N0BdznPIv8H4CFSHUq7Xi0iUNS7FKuVzaeIQw5y5bx2SKt+JZR4xzZ6X6homLLY78H2hcW9gRA4WTOi6attQYLvz170+nlgZjDEsov9fs/+CAJ8ImAAxw0ngtzGJGYFHadF9VP7VetRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHq2dSBhGbgL+Rn1bZeZQ57Pv7JaGF0llIMsByxrs3o=;
 b=d605V4vd3hqFdl2lVDEAq0PVyOmrWGRafFjBnwBsw+RL0Nh0xSUJ6BE/idIaPRXBQ7jP8JbcXlrGBkPjUTbCYl+jflxZkvdgZ59WBSG43Z9TBkskgXXnQPonGaz2vuabqo6dhUErW18FIsCXubVpbFhikh/hEefXVCbGZ8IioCs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 01:37:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 01:37:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Topic: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAPALAIAFqBsAgABumgCAABksgIAETzCAgABxe4CAA/1PgIAB1kOA
Date:   Wed, 30 Aug 2023 01:37:41 +0000
Message-ID: <20230830013739.srnh2uyhly66yvu2@synopsys.com>
References: <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
In-Reply-To: <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: 7618eca4-e43a-408d-bcf2-08dba8f9b382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+5GQaTTtvM6g2iTc8ESC2YviCPcBstCAI5SYROqdYwFN2dQmKObytIvhNrCY13xFxRu4/mIIOhey7QqYxG2eTiqRIjAxzkKUlFCEDdET+Cgo+vEXVrWHaeLJJndlSGQPFUAuVKvDs4u4pWksftMQ5cykn9ilTxtcUjOoeG13msHNLLuNxmiDBlftgcL6MGMTvlOUFP3RT/bc5BZIU95c2rVpsFvqJF419pfYQP1hnUilfE5Zfth00UtOpq2oIsZwqsheUo+SZiJnEQuseEmJGmFO9B9vTj7fBeylZJMlIzTUO87bCW5/OxFgQYQIx/sJ1GpWEuGP0NoLOtRaXa6GW//EFvO/ndwCvha8cdsmIHSR557YdA8cd3AZBP3T7uAyE184SXy5OrxlnSLe9n/FAqcKVIHXicgRepT5C57SsmHwtXwzBM7+7Vjwrphvybek5KEMrK2i9RXUnbj/yMBkyjcpWbn11CV0TNC5tKBlNdv3TutWOlrPT5VLNVyqzAbCKMBUpNDRDzfwU/6qA+SbR6vYOtJ2VE1SamEKiSRs0kAO1szwoEy/khzEyfrJ4Jw8FBIS2X8k4fIzbB0XTUhWoMDH4+zZSYTEHUpMqtSmk5S1dht0ZTvRGUwTKDDh4Xs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(38100700002)(38070700005)(316002)(41300700001)(6916009)(4326008)(7416002)(2906002)(83380400001)(86362001)(2616005)(15650500001)(26005)(1076003)(8676002)(5660300002)(36756003)(8936002)(71200400001)(66946007)(6506007)(66556008)(6486002)(66446008)(64756008)(66476007)(54906003)(53546011)(91956017)(76116006)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhweVA5MUVNbXBlbm1ibFB3OE1YWUlWZlNMQWk5OEJRSXVXaXUzRWJXWGNa?=
 =?utf-8?B?TG9nZDFUdldZcTBISWowRWFmMmdzVGozNnBPNm4rMXNiM2NBUWtaazhWV1F4?=
 =?utf-8?B?eHh5dldlSnJpYjZqNnQrcU5EbElLNGx1ZGZEYnBKUUJkQVcwQmljWkxlZkNC?=
 =?utf-8?B?ODhmR1EzVzArQkRnN0lMTDY5U1RWekRCTzJrTU43ZGpLN0xYbVpVc2xFQUc1?=
 =?utf-8?B?NTVDYkF2dEwwNHE0Y1NoQ3hzVnlZY1JFditGNlZUclVqSjhidmtKR0lVWnpZ?=
 =?utf-8?B?a0ZZTzRYTU9HL1JwR2tzOWkyUDhYOU8rUHcrMzdoKzVIQVQxVGNwT1ZNc2gr?=
 =?utf-8?B?R25EMU5IZEtDN0h4UnhXKzNSRUF6TERNTUl6Qkg3Uzg0WDdBU3dPaENiNGF3?=
 =?utf-8?B?cTNSNER6U2pzKzdmdWw5Q2l0YnlSamE3dU1sRCttUTZxcHFnMWxsQmpRbGd1?=
 =?utf-8?B?a1pWbnJCM2RSWHN4ek12a3NVVXdEczhjTUdWNWZaR3hwNGxvcWlQSkZNeXJj?=
 =?utf-8?B?blAwb0JKWUs3MzVaT3RwZVFTa1dQRUlsdW9JUzk0d2FjclRyM29uTjJ1eEhK?=
 =?utf-8?B?VWJRSTd4ZGJYUHJpMzUyYUx3QkFqQ3hjSi9wbzdNNjdPVFNuVVJBbkJTc09I?=
 =?utf-8?B?emszZDZSTzBqbER6ZmVTUFVaTUJ0Y3dCeWwxNnJ0NmtKOGY4VmY3WEFuY0VN?=
 =?utf-8?B?VThqVURteDU4NUkzOEdXTnZ6Qkt3M2J5QUQ3Y1p3ZWdWd3VaalN5NTNNRUVD?=
 =?utf-8?B?VXRmelJUZEl5bmhac29wKzlUVktPcS8weVVqNnp1U3gvRFJLMnA3RUg5ZmNY?=
 =?utf-8?B?eENyZDFZQ1lMUDRieDlSNWVxY0VEdkVMUUUwOTMyM2llcWlvZG9qQnZ1VTk2?=
 =?utf-8?B?ZE1teGlyNUtnSmx4OHJ4QzFYaXNaQ0dhN0IyazRPR3lYajdrV2lDREp6V0px?=
 =?utf-8?B?N0JGYUh0Um1kVW1uYTdqSmdqQjdaejNXeUlSclJiZ0lQOVBmMG1JeExuWUtJ?=
 =?utf-8?B?VkNDNVNqOXcrL0NGUzg4cU84UjF1NUFWSTgrcGpqNEJVL0JsaktzaUJyVXpt?=
 =?utf-8?B?amNRY2QyRk9oa1ZiN21SOVhBM1ZKUWhhT1kybHFVTTFYbWZHUC94Z0RmeU9r?=
 =?utf-8?B?aGszcHd0bGJKeGl0K0tYSnpOTTh2V2p1UTNhczlOdXNzK24rS3dNT2VaMElF?=
 =?utf-8?B?M0JBeWxyTmo3WGdoWVQxMHBZV0RCaUVkNTF1YU5TaUZGYXh3WHNuZnY2ZENE?=
 =?utf-8?B?OVc0OXpHdlhzeExFeTdSZGl1eVNTL1BmSThRZ2EvMnJ6aGl0Zk81dkpBNzVu?=
 =?utf-8?B?aUZ6aXVsN2tDTUVpK3dZUk04ZnQ2NERMYnRIbC9acU44UGJ3aUVIdGl2WFlS?=
 =?utf-8?B?bEQ1QzVBRUtoNVVDVGlCVWt6U3JXeHR1cVBncUd6MXdwaDZ4dENOa0U5VlQ0?=
 =?utf-8?B?MzB2UXBnVW80eHQ4QTZGUlJPSW5KT2Q4OXRqbVYwOS9hSTVQSEtJcGNUeDFB?=
 =?utf-8?B?ZGJsNlNGaFJPc2VLN3prZGVTUE5mamZ2aEhQY240enZXempvZUovNk9NWHM3?=
 =?utf-8?B?WkRMaHZjYkZrckQyeURBY2NXSHNiZUluN2JaSGM1VE9peWJUU2tGS3JPUStx?=
 =?utf-8?B?b3RidktvTFJKSG54anNGaDV6eDQ4WVJFbzNHRFc5L3ZEcWlGd04zTS9uc0p6?=
 =?utf-8?B?bW1rVjlrSHJCbkhxd2hUeWJaMDdWMi9Rc0JXK0UwYVJuM1FLZ0pzRmg1TUo1?=
 =?utf-8?B?R3pvUFU1WXNBSXZDRnZMUHhJMmc3RTZBQWtVdG1nUEJQUWUweEVyMGUwUWRO?=
 =?utf-8?B?azZRRldGZk41Nk02Sm9NNzlvRm15eHZRMjZFMTBWenppZzBXQVNzeGpSS2JZ?=
 =?utf-8?B?cUM2ODlTbDVuZElQWXg1c3A0blhwSFlvMEpLc01IMDZRUG1zbnBRdkdUV1Aw?=
 =?utf-8?B?MzkxZEI2TGFGdlVpSEw0bUhOKzROZjhrSHFJb0c2Z3JLREJUSktBbWQ2L3dX?=
 =?utf-8?B?UVJsbXkrd2plL1dxdnNpbk4xSzB0Rk5mWlVHRHMvUlN3bnlZOXZ0L0cvV2wy?=
 =?utf-8?B?NnRFZjdYNVJReG8zK2MxRExKcDRVczZHQkd3enhWTGdENWlUT2g1b3RwN1Yz?=
 =?utf-8?Q?a1Ku6DgTsxD8Ttti/apBCyA34?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6B3AF1452E9DD488DDE56EF5693542F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?c3ZIaXREeFc1ektRRnF2ZHF3eU01c3pDMU1mY3pGOElHbHBQTi9JSDFFUERF?=
 =?utf-8?B?U0hMdmJadmNVODFIUnVqYVE2VkJpOVhtZ0pvVlUrY0E1ZldmWldmS0FEY1Vx?=
 =?utf-8?B?REp3anlHbzJpYkw4UEhWQjhUNTFPK0cweUFoMGRSZ1RsRmhYNGVwclMzbyta?=
 =?utf-8?B?OVBzK2ZZVCs4U0I0T2ozR2pybmN5Wi9HYzZWazhySmZsdVdIamxSVVdBNk01?=
 =?utf-8?B?REpXc0FpaFI5ai9ib1hCSFFKRHEwUWNGUVNYWkZHY2VMV2h0ODV6V0tyVnpT?=
 =?utf-8?B?amU4eWVxSEpsZEF6K2J6S0E5dmFKWjJ1dUEyZmNxZEhYUVJRV1BiWjd3UUZ1?=
 =?utf-8?B?SFVZOU93VFB3cEtFSnR3N0pnSEFrb0NJWUgxb2VtOTliNjJGcnNwWDZBYm44?=
 =?utf-8?B?QjBxZTJWdWZJMEFoVXVkcFMzWUwxZG9JQ1J6bElpVE5rOXNYT0RuM21LUWJq?=
 =?utf-8?B?R2xqa1lpOWFDa3RBeHlTRldEOE9uZ29heWlJRGhTMy96S3lZRVFKQTAwamlH?=
 =?utf-8?B?ZGVXeW9oRThDV0tDRm1kTTZOSVF3bnFxaVpueUFVM2h3U1RsZ1JPTkFXSUhi?=
 =?utf-8?B?V3JGa0hkZWVyVDVDVlplN2l3NmZRLzdTSWVQdUMwVjhwSWx5dHRuWmQyTm5l?=
 =?utf-8?B?UVV5NTY3UWYvenZDK1pNZGtLWWlMS1F0UTRKMG8zRjdSa1poSFBnOTBTallp?=
 =?utf-8?B?UURPT2MwWUFLY00xVkhGcjYxRTkrK0hPRm1xTHJOZDN2Nnd3ZFlseXRyMStr?=
 =?utf-8?B?SkFacks4UkR5d0IyQ0EwSGNkRGdxOWtpVUxpdUQvblNXYzFuVzdmb0FaVDcx?=
 =?utf-8?B?bVZHMFNrVjk1VUVOemtlTXVzaUJqaFkxbTFTOVZ6RVh3MDIzbkVaelBwTHVa?=
 =?utf-8?B?NE54NkY1c2kvWEJqRGtGWVBDK3A3UURncHNFOTRLM0NYdWl6VTlwczdFRUFp?=
 =?utf-8?B?UEhIZyt1bHhESG9qcGtVTlZ4cCtLYk00UnBMZ09GcmJsT0NyNG1TbHVtbHNF?=
 =?utf-8?B?b1l4cDZva3JaYk8veWhKb29mTkxzQXgzc0ZraFhwVkNoUWQyOVZMU094WHpi?=
 =?utf-8?B?MzMzQ01pNWw1RkJHT0JUdi9UWUQxR2F2b2NkalFzTWIrY0R2aU5lTDJYc0s3?=
 =?utf-8?B?a0FqOE56NW9XSm4wVGd4VHpSYmxlMzJOUDY4dGo5SEVOT3QwcENDY3RBVlh6?=
 =?utf-8?B?REhYS1pYZkpuWFFBdVZVeEhucUFsNFc1aTJaeWdwOWYyVkRNaVgxMzNFSXBU?=
 =?utf-8?Q?/cYnQ3POre3GwAO?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7618eca4-e43a-408d-bcf2-08dba8f9b382
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 01:37:41.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3OhxxsFIsl/BD6S/yh4ltVlAYyxGlluQszZpKSABtqjRMS2y1kcjYXnGiUIIAknmW54KXKF9d1GTCMnnMW/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Proofpoint-GUID: BKMVeXZdZVVIREZtzMDKItfYTYHcjdZY
X-Proofpoint-ORIG-GUID: BKMVeXZdZVVIREZtzMDKItfYTYHcjdZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 impostorscore=0 mlxlogscore=810 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjgsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzI2LzIwMjMgMTozOSBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiAyNi8w
OC8yMDIzIDAzOjUzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBGb3IgZXhhbXBs
ZSBvbiBRdWFsY29tbSBwbGF0Zm9ybXMgdGhlcmUgaXMgYSBwaHkgc2lkZWJhbmQgc2lnbmFsbGlu
Zw0KPiA+ID4gPiA+ID4gd2hpY2ggZGV0ZWN0cyB0aGUgd2FrZXVwIHNpZ25hbCB3aGVuIHJlc3Vt
ZSBpcyBpbml0aWF0ZWQgYnkgdGhlIGhvc3QuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU28gY29t
cGF0aWJsZS1zcGVjaWZpYy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRodXMgcWNvbSBwbGF0
Zm9ybXMgY2FuIGJlbmVmaXQgZnJvbSB0aGlzIGZlYXR1cmUgYnkgZGVmaW5pbmcgdGhpcyBkdA0K
PiA+ID4gPiA+ID4gcHJvcGVydHkuIChpbiBhIHBhcmFsbGVsIGRpc2N1c3Npb24gd2l0aCBUaGlu
aCBOIHRvIGNvbWUgdXAgd2l0aCBhDQo+ID4gPiA+ID4gPiBiZXR0ZXIgbmFtZSBmb3IgdGhpcyBk
dCBlbnRyeSkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhbmtzLCB3aXRoIHF1aXRlIGEgbG9u
ZyBtZXNzYWdlIHlvdSBhdCB0aGUgZW5kIGFkbWl0dGVkIHRoaXMgaXMNCj4gPiA+ID4gPiBjb21w
YXRpYmxlLXNwZWNpZmljLiBFeGFjdGx5IHdoYXQgSSB3cm90ZSBpdCBvbmUgc2VudGVuY2UgcHJl
dmlvdXNseS4NCj4gPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gVmFyaW91cyBkd2MzIHBsYXRmb3Jt
cyBvZnRlbiBzaGFyZSBhIGNvbW1vbiBjYXBhYmlsaXR5IHRoYXQgY2FuIGJlDQo+ID4gPiBzaGFy
ZWQgd2l0aCBhIGNvbW1vbiBkdCBwcm9wZXJ0eS4gSWYgd2UgZGVkaWNhdGUgYSBwcm9wZXJ0eSBz
dWNoIGFzIGluDQo+ID4gPiB0aGlzIGNhc2UsIGl0IGhlbHBzIGRlc2lnbmVycyBlbmFibGUgYSBj
ZXJ0YWluIGZlYXR1cmUgd2l0aG91dCB1cGRhdGluZw0KPiA+ID4gdGhlIGRyaXZlciBldmVyeSB0
aW1lIGEgbmV3IHBsYXRmb3JtIGlzIGludHJvZHVjZWQuIEl0IGFsc28gaGVscHMga2VlcA0KPiA+
ID4gdGhlIGRyaXZlciBhIGJpdCBzaW1wbGVyIG9uIHRoZSBjb21wYXRpYmxlIGNoZWNrcy4NCj4g
PiANCj4gPiBUaGF0J3Mgbm90IHRoZSBwdXJwb3NlIG9mIGJpbmRpbmdzLiBTb3JyeS4NCj4gPiAN
Cj4gPiA+IA0KPiA+ID4gUmVnYXJkbGVzcywgd2hhdCBLcnp5c3p0b2Ygc2FpZCBpcyB2YWxpZC4g
UGVyaGFwcyB3ZSBjYW4gbG9vayBpbnRvDQo+ID4gPiBlbmhhbmNpbmcgZHdjMyB0byBtYWludGFp
biBzaGFyZWQgYmVoYXZpb3IgYmFzZWQgb24gY29tcGF0aWJsZSBpbnN0ZWFkPw0KPiA+IA0KPiA+
IA0KPiBUaGFuayB5b3UgS3J6eXN6dG9mLCBUaGluaCwgUm9nZXIgZm9yIHlvdXIgY29tbWVudHMg
YW5kIGZlZWRiYWNrLiBJIHdpbGwNCj4gdXBsb2FkIHY1IG1ha2luZyB0aGlzIGNoYW5nZSBjb21w
YXRpYmxlLXNwZWNpZmMuDQo+IA0KDQpIaSBFbHNvbiwNCg0KSnVzdCB3YW50IHRvIGNsYXJpZnks
IHRoZXJlIGFyZSBkd2MzIHByb3BlcnRpZXMgYW5kIHRoZXJlIGFyZSBkdCBiaW5kaW5nDQpwcm9w
ZXJ0aWVzLiBPZnRlbiB0aGUgY2FzZSB0aGF0IGR0IGJpbmRpbmcgbWF0Y2hlcyAxLXRvLTEgd2l0
aCBkd2MzDQpkcml2ZXIgcHJvcGVydHkuIE5vdywgd2UgbmVlZCB0byBlbmhhbmNlIHRoZSBjaGVj
a2VycyBzbyB0aGF0IHRoZSBkd2MzDQpkcml2ZXIgcHJvcGVydHkgdG8gbWF0Y2ggY2FzZXMgd2hl
cmUgaXQgaXMgcGxhdGZvcm0gc3BlY2lmaWMgYW5kIHRocm91Z2gNCmNvbXBhdGlibGUgc3RyaW5n
Lg0KDQpUaGFua3MsDQpUaGluaA==
