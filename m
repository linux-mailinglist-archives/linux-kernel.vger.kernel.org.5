Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6AF78932F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHZByG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjHZBxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:53:38 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8D2106;
        Fri, 25 Aug 2023 18:53:35 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKJC5M020690;
        Fri, 25 Aug 2023 18:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=RfXTv0Q0aPc1XDNlCGQFLptQDtcKwMDL81cJSONVb3A=;
 b=QW2bjFL13VoxBgKM4gw48fCM0nG5L+VkWjR5Zq+oHLi4m89o0lcece2K2TMxKytEUXxP
 J35rkQYRvsV1WlrMa6QFd57IEH0QFpeU1vfV+R/O20E80aoEe9FFhLPYZrMKW+ktUHC6
 oxKR5esioCUzgZZ1cdEOhwuNHN0bUZLTEdxJP9G6HTI5lRXdRq28WezzFPxSSm5uochW
 M7di1DbDMJtd+Kp9NmgZGOYhv1ZyX6ScYAQjt+Q2s7Wj0XxTB9LyOtOdDqYwJiYfiBX9
 tZjJNyqIzCmBPGa+RFD2GOD9/SaFmtjQk4atZkXi5QKbItGRwepivfxyw4ggpM4K+BFv LQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3spmqf4r7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693014790; bh=RfXTv0Q0aPc1XDNlCGQFLptQDtcKwMDL81cJSONVb3A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mBhiohMwCv1sgCmGZjvUP1IEoHWUWgA0J4TKdrURTGHymj466c00PRALAQAjKqqvQ
         nlifotuUUP6YR+RwX3kVzyrAJu4c7LAc5H4eDUr4PjDtr0hsGjErSfDt9y0QatIX11
         XE1Q20TF27N7zp3gkbyGN3kgD594P3PLyredE3uNxAkSnIAR8TkZGHRXQbJXXxXpCT
         zUNcIk0nv0Y/W7HatCUAhRByLU5EkHivskQEN/vAZ5OaTjB1twAGoYyjsJmJWAQeSt
         o+MRaHmF4r9BTB/dWQenYbxvROdbJGTLzLxunaSUlSr0bKYmCW8yb0vJ2w28qv8YuV
         oZZHRMeylfmAg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7D5C24024D;
        Sat, 26 Aug 2023 01:53:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 618F5A005C;
        Sat, 26 Aug 2023 01:53:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NRMfhbyj;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C9443404AC;
        Sat, 26 Aug 2023 01:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/6GunlbPRoH2JaBr7DvJzjY5/wab7ZHJZYDfictr6o6+VLYK3rYlbvQYfvg2xlmBfKZiv47ZCjlHTlkMYKNTQ1oLWqkn9+g5yt683ekmlYfBgncDccf9htcOFNrK/RY/SdHtImll0b9e0jqcxdYX98K/udAjNW69zARU0Z0TrbugWtZ7Eks7wBk8ZUXh7IcwpGL9lIU94KcJ78Qe3FEkBsyo1Wowire3qZziH+C39fgV3aBudb79ZEFAmzSoYqAVS4aydrEw3z5+dd0TUiz5dGqmrvVOrymWdfIgDab2QktlgIImZOJaSHOR18VDKk56yEQXOHN0BmiVgoxgP44Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfXTv0Q0aPc1XDNlCGQFLptQDtcKwMDL81cJSONVb3A=;
 b=nD/2lBFaA3y0mG465LfLJ53Ub4246naq3eFDtTJNVS3u6nKlremu1WGArVNIiBn+Us61N9kuZkFytsbckoCH6Kn76CQ9Op4fMF/Ue1ZGcOpagOGmysUwBySsONURQ21WihoTbs4bcUb3zHEO8UY8ocYAQxaj5DG0hLOTcPJVS/goyV4COOALNPqE0aizLRw7CTV7bnTEXuNe7xBsN9rsDSdmDVOjNyUsp8OzCD2nwOJvSOnUr+/ST01TSx+m1Wns9aJ+Bmfy715y7GiqbBp7raxc0e42pJP/CpH9edyS3nrZ2ycMrdU0/iaj/zcVEBodWRA3aXg+hm0G9LY8DAfhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfXTv0Q0aPc1XDNlCGQFLptQDtcKwMDL81cJSONVb3A=;
 b=NRMfhbyj9h0sr4EyCjiqKjqfhFkVgQ6uc0cbFpeP0/oZzpji96R2HaNFStXPxPd1z9QpU2lbDxd5742eoYZXWrodU2Zj1zkyUML6EQCO/Bl6snkK3PYHbuqaiEJ79hhVpUwAcEsO54+7Pn9Wr6G915oe48fkTy07aqF3tdQj+sw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Sat, 26 Aug
 2023 01:53:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 01:53:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>,
        Elson Serrao <quic_eserrao@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAPALAIAFqBsAgABumgCAABksgIAETzCA
Date:   Sat, 26 Aug 2023 01:53:02 +0000
Message-ID: <20230826015257.mbogiefsbz5474ft@synopsys.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
In-Reply-To: <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BN9PR12MB5241:EE_
x-ms-office365-filtering-correlation-id: 4f8940ca-2127-487b-e3c3-08dba5d72eb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mZM3n5TJHoDuLsjJB+0hWJJVEAaZJBg8P0U5lUh0zDnpCqI1/+8bRLfzGPFIx6to3oHz3XiZMRLGauegU2omXtA0emwU7CTsSb1HickTi/JyxGBpi4TsfRy0pRoz3hGxnPUnDgP/GjELSI8OSB59NLftm6H+v2zl7CFBtsfGcBXVWOr/cDvmxDpfui8wpr+MYnbrszvbGpZJmDZClT08KYprerPwKJ+Ec3pKuJFRbhK6E6QrDj8V/4LQjqtMcLNwnakcSAlEoIN79zUnXjw5SQiOHZCS0PmH3l7Fo4+xf3R4HwmcxjSmXn2zSYShqEriI0359SzIOL1qEgQR3zAmC/5U08PHX7+vI2GsqiXwhuS57k4zHdeoTcfBuJ8mGxVVKkEN+IjW+neUrlqE9J/nzTtnul9mWM5HD/bilUyHfCoWlc1dihKWaZyIK8FeL/ga+1hu2+kFTesPlN1dJNpH3PVp65DgVJeAmdQBOKrZIf0peVUaOMssIkov4WJ6slo7PCnn0BfWLW79+tEpkpHszqOGxGsj0n0vdUCEXnSRGpl0TU7BWwPr569GIeUt2z3Qv226khKW6ZqDxR0SlkDJK0DYfsZHBRdiZXJ/SQq85eptONdMbRQhUOnIUFGl6qB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(1800799009)(451199024)(186009)(122000001)(38100700002)(38070700005)(8676002)(4326008)(8936002)(54906003)(41300700001)(64756008)(6506007)(53546011)(6486002)(66446008)(316002)(91956017)(36756003)(76116006)(66476007)(66556008)(86362001)(66946007)(71200400001)(110136005)(6512007)(7416002)(26005)(478600001)(1076003)(83380400001)(15650500001)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNIeWtNdklidWZ0K1F1bERqU240RUlzdFJoT1BKYTNNWEVOQkUvU0duOVdZ?=
 =?utf-8?B?aml1bldNVzRlU2RzcFpaaEtWR2VzV1pFZ3NYTlB2aVNhcHpiK2t5QkxkbVZm?=
 =?utf-8?B?eHRLd1JWYnowRlJtMkNLSzQvVkxBSFdYRUVzV1VoL1F2cTRqMDVMeXhZbnNR?=
 =?utf-8?B?ZHBZOTYyZnFoRnE5SnpoOC9Va2J4cW43UHNBNVdyNVREK0N5M0lteWRUS0tT?=
 =?utf-8?B?QmVPMW9jV29zNUdzZE8yakhKTWZtZnRXNmNFakdLWUpCdG04K2c3Ymo2bHVF?=
 =?utf-8?B?TUtheUtLK1pMQ0FTNmRxZFl3WENpRDVrY2FidWJrMmRFdCtNc1VHd1BYemk3?=
 =?utf-8?B?RDhUMXBRcWJCeW43YVF1dEFMd3pieGhjVzRJT2M3ZU1PdzVQR1Z3c1hzR1gv?=
 =?utf-8?B?WVhwczg1eVNzOXBqTDJRazc0SGdKd3YvYTc3VWRmUzg3YVFQRkdQNVhMcGdu?=
 =?utf-8?B?TlBJd0lZWTlBY0s5N3YrUzlYY09obU94aDI4eng1YkV5Nnd5OWQwMjZoL3hl?=
 =?utf-8?B?SkNDaUcwNmd2Y1UwVUxaRUpxV21LSnpsdTR2a3M1ZFRCKzJxTERFcDZ1M0o0?=
 =?utf-8?B?VmMvY21qd253U1BRNHFuNVhFb2lNQ254dzR5VEFTeEFKQWtUcVVGdXMxMEVQ?=
 =?utf-8?B?QktacHhVdlVVV1IyMmwwbHlWRStNTmpaOVBoTEc0ejZibTJSNHdoSmprNkdy?=
 =?utf-8?B?Y01LQXd3UkRWaGE1RGE0WDNtWlFaU0h0QW9obTd4eFg1OVFUYjNodks3YXJt?=
 =?utf-8?B?SWpTbTV3U2ZWclhaWFcxc1ROc3c5NkxLdXA5NUo5UDl5QmcyT1hWR2RJbUhR?=
 =?utf-8?B?end6VzdtaWU1R3FPalAzVUZLZCtPa28yOTcxbTk4TU53NTJ2RTRtdWpNdlNa?=
 =?utf-8?B?b210aDU2ZXU2RzFWVGNCb1NIU3Vid3F3aHQ0dkZkZkcvcms5a1NqVDhWajB1?=
 =?utf-8?B?MUxFWTlHVndoSkhlVlZESmNwYmJreHNHVUpIUGJpYUNMeC9kSnJmQjZWOVJk?=
 =?utf-8?B?aWpDOURpK0JiV1kwUHIzTis1Q0diNWRCd2V2T29vRDlPKzdyVk8vWFNkMU51?=
 =?utf-8?B?eC9LdEc2SUlSWUxObU5RR1paZ1dMY21xTGNUdFd6QmhBTSt3TGlab29pcDlX?=
 =?utf-8?B?N3l1NGc0RVN6KzE1Sm5YanlLUnZYMW5nM1VkWnJrbG8zYk1kSlArNTh3UWdO?=
 =?utf-8?B?RURUMzlLUkRoZ0xFUERhaDVhMXJMOFdieldTVWVTSVBGSXdzUDl0dE9rZVVh?=
 =?utf-8?B?TEZTckVVT2orSEtPdWhBbVZsak1xaHljOTgxSVFJNmZYKzR6ZnNkT1pmZjJO?=
 =?utf-8?B?dGwzdnZoNjZJem1aT2F3R0hhSTRtUzlMNjcvakVCK1haTFBaNnFZSWY2Z3Ri?=
 =?utf-8?B?UHRRRk96alk0ZXhCUEdtditrVXFNWUVGbXlEVUc5M2VpU21kYmsvbi9WOGU5?=
 =?utf-8?B?YVhYbHZROUhjT285Y0JxSVdqWDM3KzUxYzRvaGxkNUR5T3NPZ3RLUk15RHht?=
 =?utf-8?B?NnRmY3NmSlB4dHo4OHpQRmlVTFh5cW1BcmdpdlZkbGs2SFVIQzhGdzNhVjF6?=
 =?utf-8?B?QlM5SGpOQUtrRTdZaTBsQ2R0SWoyVENVSVZHNFRJV3p0VHh0SGdacU9YeDlX?=
 =?utf-8?B?bnFRRk9IYTFFU0IxL2QxSGtTeTVMQVR6ay9kR1U2bmNUbnQ5THY3MmdOK1Z0?=
 =?utf-8?B?ZlhxMHcxOVplU1M1S3RXWlVLN1VDVmtrNHV5RTAvT2hjYUtGK2ZDRExNNW41?=
 =?utf-8?B?MkViWjhkc2lnWi83N0FmOGtVcnJJZXBiTzBhVk1QdXkydHB0cmVaZjMyTm8x?=
 =?utf-8?B?cU1Oc0JLR09uM28yTlFGK21TR0FtN3l4Q2ZzTHFvQ3N4YXM1dHovSVAxcHhz?=
 =?utf-8?B?aWxwUFo0QStIdXRGSVJoNitqRUtGdkZpaVAvR0xTcWVWVU9XZkcyUC95MW9n?=
 =?utf-8?B?Z2lUZXk4akJSSEc1NGRtbmZoaTU4WTBOWTNvWGVDRXEyT2JKMjBjSFlsZ2gx?=
 =?utf-8?B?ZzhZYStxS2RBN3ZWbStqRDVFSTBFOGxnZDNwY2NHODRlQjF6blZndHplTnZo?=
 =?utf-8?B?RmhnamlGUm1RNUhjUmNPZjJMZjU3U292M3dDR2ExZU5zV0tSblRmRkZjWXpp?=
 =?utf-8?B?d0hBeGg2dEtwSmNrY293dmp3S0pDUHRmSWwwRGpsc205YkJpbjJ6UVFnZEto?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B98C40B8A15C4EB54122E0BDF51F92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y1p4L1JnV2R2ekFHQzFGN0poZU5GcThMTnRuR3NDVHFkOTgrbGlab1pQc0dv?=
 =?utf-8?B?TWJDR3lrelI3bFJJcjgzcmlUYUo1RWtPZGJreFJITzNralhUZnV5cHo0Znlq?=
 =?utf-8?B?S2tjVXdKQjVkYnNVUTJZckRRWGo2L0tRTENvM1FpT1EvTFQxWlUwN3JCN1Qw?=
 =?utf-8?B?RFo0aTlMOHBrNTZCT0c3UzJFT3c3OU1TcG5wZ0RFSzNORlB6OStFaTJWK3BV?=
 =?utf-8?B?SG9nSkE0VC9iaGRqeDhYM3dycjB2NldJY20rVjlJZWczSjNUeEVZMXVENXA4?=
 =?utf-8?B?WDZCMTE0RHUxWjFSc3RkcHVYTld4RTB5WnE2Y1d2bHV6UE9MaFZnaE9xT2Nj?=
 =?utf-8?B?NTN0UVBhalRCT3N3NW9TL3lyOU1JSlo2TVB6azVwS3pER0NCcWNoMWdrRU5i?=
 =?utf-8?B?OHdVZTdWVkowSm1vOEhGWUtFcGlOWHYrbEM3LzRXOFNsUE1wc0MvQzFQWnhD?=
 =?utf-8?B?NWh1allxWC8yVEVZQ2JvN2RUUjdRQmtnc1VZSFlFN3dWUGp5c1Rub3ZlVzVt?=
 =?utf-8?B?QnBiZysrdWMxMkRJT2swSmoxYll6cHE1WFMvSFFyTVZYL1ZnRTd0Q3B4RjlY?=
 =?utf-8?B?Y0taRFZnaHYzVW9pdHhrc2UzTEd5OFg1Sk9UY2wzNVM4cjFhT3JrSUE5UVVq?=
 =?utf-8?B?MW5YMmZlUEhjNG1IU29zQzJoeDBDOXpUS0VzaktYaU1HMm96cDFiMUZWbnlO?=
 =?utf-8?B?NHBZdVRlU01PbVUyZEl3Mnd4dFM2Ym5kL2JzK0U5YlJrVFh1YUJOT2FOT3pU?=
 =?utf-8?B?Sm5SSkZWY21LZGJMQit1R25qenFraUN4SjFObXJYQkg4b3VTNm1rbWdlRnJs?=
 =?utf-8?B?Q3Q4QXNrWjNlQjB2TXFndWw2clZvdUpuZFNJSW5xcGpxMUlwRFBBalpydzdz?=
 =?utf-8?B?cldhVDNnZG5jTFpMQ1ZidVozSGphcjlDNTRybXM2dXJyZFJKT0xSTkEvVk5O?=
 =?utf-8?B?dFVhcmgzM0hacEcxY2Y3eTZVNUY4SFlJbU5tYmNyNFZDeFhqWnNlOHZyMDVz?=
 =?utf-8?B?SEFBL3dzS0FhcGNTaVpNVFVFNUFIVEFDcm1iVGFKVU5Jc0hFSTZyWW0raXVo?=
 =?utf-8?B?N0VFQ3k2azd4Y0VGb3hxQU5IR1J4dFdOdHF2STdUZWN5c1RUMCtEMTV6MWQ5?=
 =?utf-8?B?QkZQUlRSYlRJL2F4bUQyVGFNNFgva0xub0JCY09SOWtHRHN4b29kUTNGL3Jt?=
 =?utf-8?B?bzJVakcrWHh4TWxUbTdrWk90SUdIWGNycG10TlZ5TmJxM0NPR3k3T3ZoVGxZ?=
 =?utf-8?Q?TJ/t3HG3/cyRKkA?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8940ca-2127-487b-e3c3-08dba5d72eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 01:53:02.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DPP+5T45BBDmZOVkpr8TSxhzBUH+T9zBXtrFl8so24UUgYydmSxnuBC0g0JFHLb19hfPSFPjQpZbZZ3qHSd5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
X-Proofpoint-ORIG-GUID: orVDKPsVYk_s5geudSnVmLEked_f9so7
X-Proofpoint-GUID: orVDKPsVYk_s5geudSnVmLEked_f9so7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=521 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308260016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MjMvMDgvMjAyMyAwOTozNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiAyMy8w
OC8yMDIzIDAxOjU4LCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDgv
MTkvMjAyMyAyOjM1IEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+Pj4gT24gMTgv
MDgvMjAyMyAyMToxNiwgRWxzb24gU2VycmFvIHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+
PiBPbiA4LzE1LzIwMjMgMTA6NDQgUE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+
Pj4+IE9uIDE0LzA4LzIwMjMgMjA6NTAsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4+Pj4+
PiBUaGlzIHByb3BlcnR5IGFsbG93cyBkd2MzIHJ1bnRpbWUgc3VzcGVuZCB3aGVuIGJ1cyBzdXNw
ZW5kIGludGVycnVwdA0KPiA+Pj4+Pj4gaXMgcmVjZWl2ZWQgZXZlbiB3aXRoIGNhYmxlIGNvbm5l
Y3RlZC4gVGhpcyB3b3VsZCBhbGxvdyB0aGUgZHdjMw0KPiA+Pj4+Pj4gY29udHJvbGxlciB0byBl
bnRlciBsb3cgcG93ZXIgbW9kZSBkdXJpbmcgYnVzIHN1c3BlbmQgc2NlbmFyaW8uDQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gVGhpcyBwcm9wZXJ0eSB3b3VsZCBwYXJ0aWN1bGFybHkgYmVuZWZpdCBkd2Mz
IElQcyB3aGVyZSBoaWJlcm5hdGlvbiBpcw0KPiA+Pj4+Pj4gbm90IGVuYWJsZWQgYW5kIHRoZSBk
d2MzIGxvdyBwb3dlciBtb2RlIGVudHJ5L2V4aXQgaXMgaGFuZGxlZCBieSB0aGUNCj4gPj4+Pj4+
IGdsdWUgZHJpdmVyLiBUaGUgYXNzdW1wdGlvbiBoZXJlIGlzIHRoYXQgdGhlIHBsYXRmb3JtIHVz
aW5nIHRoaXMgZHQNCj4gPj4+Pj4+IHByb3BlcnR5IGlzIGNhcGFibGUgb2YgZGV0ZWN0aW5nIHJl
c3VtZSBldmVudHMgdG8gYnJpbmcgdGhlIGNvbnRyb2xsZXINCj4gPj4+Pj4+IG91dCBvZiBzdXNw
ZW5kLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8g
PHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gICAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCB8IDUgKysr
KysNCj4gPj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPj4+Pj4+
DQo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9zbnBzLGR3YzMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2Ivc25wcyxkd2MzLnlhbWwNCj4gPj4+Pj4+IGluZGV4IGE2OTZmMjM3MzBkMy4uZTE5YTYwZDA2
ZDJiIDEwMDY0NA0KPiA+Pj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pj4+Pj4gQEAgLTQwMyw2ICs0
MDMsMTEgQEAgcHJvcGVydGllczoNCj4gPj4+Pj4+ICAgICAgICBkZXNjcmlwdGlvbjoNCj4gPj4+
Pj4+ICAgICAgICAgIEVuYWJsZSBVU0IgcmVtb3RlIHdha2V1cC4NCj4gPj4+Pj4+ICAgIA0KPiA+
Pj4+Pj4gKyAgc25wcyxydW50aW1lLXN1c3BlbmQtb24tdXNiLXN1c3BlbmQ6DQo+ID4+Pj4+PiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4+Pj4gKyAgICAgIElmIFRydWUgdGhlbiBkd2MzIHJ1bnRp
bWUgc3VzcGVuZCBpcyBhbGxvd2VkIGR1cmluZyBidXMgc3VzcGVuZA0KPiA+Pj4+Pj4gKyAgICAg
IGNhc2UgZXZlbiB3aXRoIHRoZSBVU0IgY2FibGUgY29ubmVjdGVkLg0KPiA+Pj4+Pg0KPiA+Pj4+
PiBUaGlzIHdhcyBubyB0ZXN0ZWQuLi4gYnV0IGFueXdheSwgdGhpcyBpcyBubyBhIERUIHByb3Bl
cnR5IGJ1dCBPUw0KPiA+Pj4+PiBwb2xpY3kuIFRoZXJlIGlzIG5vIHN1Y2ggdGhpbmcgYXMgInJ1
bnRpbWUgc3VzcGVuZCIgaW4gdGhlIGhhcmR3YXJlLA0KPiA+Pj4+PiBiZWNhdXNlIHlvdSBkZXNj
cmliZSBvbmUgcGFydGljdWxhciBPUy4NCj4gPj4+Pj4NCj4gPj4+Pj4gU29ycnksIG5vIGEgRFQg
cHJvcGVydHksIGRyb3AgdGhlIGNoYW5nZSBlbnRpcmVseS4NCj4gPj4+Pj4NCj4gPj4+Pj4NCj4g
Pj4+PiBIaSBLcnp5c3p0b2YNCj4gPj4+Pg0KPiA+Pj4+IFNvcnJ5IG15IGxvY2FsIGR0IGNoZWNr
ZXIgaGFkIHNvbWUgaXNzdWUgYW5kIGl0IGRpZCBub3QgY2F0Y2ggdGhlc2UNCj4gPj4+PiBlcnJv
cnMuIEkgaGF2ZSByZWN0aWZpZWQgaXQgbm93Lg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBkdCBwcm9w
ZXJ0eSBpcyBtYWlubHkgZm9yIHNraXBwaW5nIGR3YzMgY29udHJvbGxlciBoYWx0IHdoZW4gYSBV
U0INCj4gPj4+PiBzdXNwZW5kIGludGVycnVwdCBpcyByZWNlaXZlZCB3aXRoIHVzYiBjYWJsZSBj
b25uZWN0ZWQsIHNvIHRoYXQgd2UgZG9udA0KPiA+Pj4+IHRyaWdnZXIgYSBESVNDT05ORUNUIGV2
ZW50LiBQZXJoYXBzIGEgYmV0dGVyIG5hbWUgd291bGQgcmVmbGVjdCB0aGUgdHJ1ZQ0KPiA+Pj4+
IHVzYWdlIG9mIHRoaXM/DQo+ID4+Pj4NCj4gPj4+PiBTb21ldGhpbmcgbGlrZSBzbnBzLHNraXAt
ZHdjMy1oYWx0LW9uLXVzYi1zdXNwZW5kLiBkd2MzIGNvcmVzIHdoZXJlDQo+ID4+Pj4gaGliZXJu
YXRpb24gZmVhdHVyZSBpcyBub3QgZW5hYmxlZC9zdXBwb3J0ZWQgY2FuIHVzZSB0aGlzIHByb3Bl
cnR5DQo+ID4+Pg0KPiA+Pj4gU28gdGhpcyBpcyBzcGVjaWZpYyB0byBEV0MzIGNvcmUsIHRodXMg
c2hvdWxkIGJlIGp1c3QgaW1wbGllZCBieSBjb21wYXRpYmxlLg0KPiA+Pj4NCj4gPj4NCj4gPj4g
SGkgS3J6eXN6dG9mDQo+ID4+DQo+ID4+IEFwb2xvZ2llcyBmb3Igbm90IGJlaW5nIGNsZWFyLiBC
ZWxvdyBpcyB0aGUgcmVhc29uaW5nIGJlaGluZCB0aGlzIGR0IGVudHJ5Lg0KPiA+Pg0KPiA+PiBX
aGVuIGJ1cyBzdXNwZW5kIGludGVycnVwdCBpcyByZWNlaXZlZCBhbmQgaWYgdXNiIGNhYmxlIGlz
IGNvbm5lY3RlZCwgDQo+ID4+IGR3YzMgZHJpdmVyIGRvZXMgbm90IHN1c3BlbmQuIFRoZSBhaW0g
b2YgdGhpcyBzZXJpZXMgaXMgdG8gaGFuZGxlIHRoaXMgDQo+ID4+IGludGVycnVwdCB3aGVuIFVT
QiBjYWJsZSBpcyBjb25uZWN0ZWQgdG8gYWNoaWV2ZSBwb3dlciBzYXZpbmdzLiBPRU1zIA0KPiA+
PiBtaWdodCBoYXZlIHRoZWlyIG93biBpbXBsZW1lbnRhdGlvbiBpbiB0aGVpciBnbHVlIGRyaXZl
ciB0byB0dXJuIG9mZiANCj4gPj4gY2xvY2tzIGFuZCBvdGhlciByZXNvdXJjZXMgd2hlbiBVU0Ig
aXMgbm90IGluIHVzZSwgdGh1cyBzYXZpbmcgcG93ZXIuIA0KPiA+PiBCdXQgc2luY2UgZ2x1ZSBs
YXllciBoYXMgZGVwZW5kZW5jeSBvbiBkd2MzIGRyaXZlciAocGFyZW50LWNoaWxkIA0KPiA+PiBy
ZWxhdGlvbnNoaXApIHdlIG5lZWQgdG8gYWxsb3cgZHdjMyBkcml2ZXIgdG8gTk9UIGlnbm9yZSB0
aGUgYnVzIHN1c3BlbmQgDQo+ID4+IGludGVycnVwdCBhbmQgbGV0IHRoZSBkd2MzIGRyaXZlciBz
dXNwZW5kIChzbyB0aGF0IGdsdWUgZHJpdmVyIGNhbiANCj4gPj4gc3VzcGVuZCBhcyB3ZWxsKQ0K
PiA+IA0KPiA+IEFsbCB0aGlzIGRlc2NyaWJlcyBjdXJyZW50IE9TIGltcGxlbWVudGF0aW9uIHNv
IGhhcyBub3RoaW5nIHRvIGRvIHdpdGgNCj4gPiBiaW5kaW5ncy4NCj4gPiANCj4gPj4NCj4gPj4g
Tm93IGl0IGlzIHRoZSByZXNwb25zaWJpbGl0eSBvZiBnbHVlIGRyaXZlciB0byBkZXRlY3QgVVNC
IHdha2V1cCBzaWduYWwgDQo+ID4+IGZyb20gdGhlIGhvc3QgZHVyaW5nIHJlc3VtZSAoc2luY2Ug
ZHdjMyBkcml2ZXIgaXMgc3VzcGVuZGVkIGF0IHRoaXMgDQo+ID4+IHBvaW50IGFuZCBjYW5ub3Qg
aGFuZGxlIGludGVycnVwdHMpLiBFdmVyeSBPRU0gbWF5IG5vdCBoYXZlIHRoZSANCj4gPj4gY2Fw
YWJpbGl0eSB0byBkZXRlY3Qgd2FrZXVwIHNpZ25hbC4gDQo+ID4gDQo+ID4gQWdhaW4sIGRyaXZl
ciBhcmNoaXRlY3R1cmUuDQo+IA0KPiBUaGlzIGlzIG5vdCBkcml2ZXIgYXJjaGl0ZWN0dXJlIGJ1
dCBTb0MgKGhhcmR3YXJlKSBhcmNoaXRlY3R1cmUuDQo+IE1vc3QgU29DcyBoYXZlIHNvbWUga2lu
ZCBvZiBXcmFwcGVyIGgvdyBsb2dpYyBhcm91bmQgdGhlIFVTQiBoL3cgbW9kdWxlDQo+IHdoZXJl
IHRoZXkgaW1wbGVtZW50IHN1Y2ggbG9naWMgbGlrZSBwb3dlci9jbG9ja2luZy93YWtlLXVwIGhh
bmRsaW5nIGV0Yy4NCj4gU28gdGhpcyBpbmZvcm1hdGlvbiAod2hldGhlciB3YWtlLXVwIGlzIHN1
cHBvcnRlZCBvciBub3QpDQo+IHNob3VsZCBiZSBhbHJlYWR5IGtub3duIHRvIHRoZSByZXNwZWN0
aXZlIFdyYXBwZXIgZHJpdmVyLg0KPiANCj4gTm93IHRoZSBtaXNzaW5nIHBhcnQgaXMgaG93IHRv
IGNvbnZleSB0aGlzIGluZm9ybWF0aW9uIHRvIHRoZSBVU0IgKERXQzMpDQo+IGRyaXZlciBzbyBp
dCBiZWhhdmVzIGluIHRoZSBjb3JyZWN0IHdheS4NCj4gDQo+ID4gDQo+ID4+IFRoZSBnb2FsIG9m
IHRoaXMgZHQgcHJvcGVydHkgaXMgZm9yIA0KPiA+PiB0aGUgZHdjMyBkcml2ZXIgdG8gYWxsb3cg
aGFuZGxpbmcgb2YgdGhlIGJ1cyBzdXNwZW5kIGludGVycnVwdCB3aGVuIHN1Y2ggDQo+ID4gDQo+
ID4gRFQgcHJvcGVydGllcyBhcmUgbm90ICJmb3IgdGhlIGRyaXZlcnMiLg0KPiA+IA0KPiA+PiBh
IGNhcGFiaWxpdHkgZXhpc3RzIG9uIGEgZ2l2ZW4gSFcgcGxhdGZvcm0uIFdoZW4gdGhpcyBwcm9w
ZXJ0eSBpcw0KPiA+IA0KPiA+IEVhY2ggcGxhdGZvcm0gaGFzIHRoaXMgY2FwYWJpbGl0eS4gSWYg
bm90LCB0aGVuIGl0IGlzDQo+ID4gY29tcGF0aWJsZS1yZWxhdGVkLCBhcyBJIHNhaWQgYmVmb3Jl
IHdoaWNoIHlvdSBkaWQgbm90IGFkZHJlc3MuDQo+ID4gDQo+ID4gDQo+ID4+IGRlZmluZWQgZHdj
MyBkcml2ZXIga25vd3MgdGhhdCB0aGUgbG93IHBvd2VyIG1vZGUgZW50cnkvZXhpdCBpcyANCj4g
Pj4gY29udHJvbGxlZCBieSB0aGUgZ2x1ZSBkcml2ZXIgYW5kIHRodXMgaXQgY2FuIGFsbG93IHRo
ZSBzdXNwZW5kIA0KPiA+PiBvcGVyYXRpb24gd2hlbiBidXMgc3VzcGVuZCBpbnRlcnJ1cHQgaXMg
cmVjZWl2ZWQuDQo+ID4+DQo+ID4+IEZvciBleGFtcGxlIG9uIFF1YWxjb21tIHBsYXRmb3JtcyB0
aGVyZSBpcyBhIHBoeSBzaWRlYmFuZCBzaWduYWxsaW5nIA0KPiA+PiB3aGljaCBkZXRlY3RzIHRo
ZSB3YWtldXAgc2lnbmFsIHdoZW4gcmVzdW1lIGlzIGluaXRpYXRlZCBieSB0aGUgaG9zdC4NCj4g
PiANCj4gPiBTbyBjb21wYXRpYmxlLXNwZWNpZmljLg0KPiA+IA0KPiA+PiBUaHVzIHFjb20gcGxh
dGZvcm1zIGNhbiBiZW5lZml0IGZyb20gdGhpcyBmZWF0dXJlIGJ5IGRlZmluaW5nIHRoaXMgZHQg
DQo+ID4+IHByb3BlcnR5LiAoaW4gYSBwYXJhbGxlbCBkaXNjdXNzaW9uIHdpdGggVGhpbmggTiB0
byBjb21lIHVwIHdpdGggYSANCj4gPj4gYmV0dGVyIG5hbWUgZm9yIHRoaXMgZHQgZW50cnkpLg0K
PiA+IA0KPiA+IFRoYW5rcywgd2l0aCBxdWl0ZSBhIGxvbmcgbWVzc2FnZSB5b3UgYXQgdGhlIGVu
ZCBhZG1pdHRlZCB0aGlzIGlzDQo+ID4gY29tcGF0aWJsZS1zcGVjaWZpYy4gRXhhY3RseSB3aGF0
IEkgd3JvdGUgaXQgb25lIHNlbnRlbmNlIHByZXZpb3VzbHkuDQo+ID4gDQoNClZhcmlvdXMgZHdj
MyBwbGF0Zm9ybXMgb2Z0ZW4gc2hhcmUgYSBjb21tb24gY2FwYWJpbGl0eSB0aGF0IGNhbiBiZQ0K
c2hhcmVkIHdpdGggYSBjb21tb24gZHQgcHJvcGVydHkuIElmIHdlIGRlZGljYXRlIGEgcHJvcGVy
dHkgc3VjaCBhcyBpbg0KdGhpcyBjYXNlLCBpdCBoZWxwcyBkZXNpZ25lcnMgZW5hYmxlIGEgY2Vy
dGFpbiBmZWF0dXJlIHdpdGhvdXQgdXBkYXRpbmcNCnRoZSBkcml2ZXIgZXZlcnkgdGltZSBhIG5l
dyBwbGF0Zm9ybSBpcyBpbnRyb2R1Y2VkLiBJdCBhbHNvIGhlbHBzIGtlZXANCnRoZSBkcml2ZXIg
YSBiaXQgc2ltcGxlciBvbiB0aGUgY29tcGF0aWJsZSBjaGVja3MuDQoNClJlZ2FyZGxlc3MsIHdo
YXQgS3J6eXN6dG9mIHNhaWQgaXMgdmFsaWQuIFBlcmhhcHMgd2UgY2FuIGxvb2sgaW50bw0KZW5o
YW5jaW5nIGR3YzMgdG8gbWFpbnRhaW4gc2hhcmVkIGJlaGF2aW9yIGJhc2VkIG9uIGNvbXBhdGli
bGUgaW5zdGVhZD8NCg0KVGhhbmtzLA0KVGhpbmg=
